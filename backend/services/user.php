<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$pageID = 4;

$router->add('POST', '/master/users', function () {
    $pageID=4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 1
    ];
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);

    if (!empty($data)) {
        $payload = (object) $data;
    }



    $db = new Database();
    $sqlQuery = $db->generateDynamicQuery("users",  $payload->fields);

    if ($isAdmin && $_info->branch_id == null) {
        $sqlQuery = $sqlQuery . " WHERE status = TRUE LIMIT  ?  OFFSET  ?;";
        $stmt = $db->query($sqlQuery, [$payload->max, $payload->current]);
    } else {
        $sqlQuery .= " WHERE user_id IN (
    SELECT user_id FROM representatives 
    WHERE branch_id = (
        SELECT branch_id FROM representatives 
        WHERE user_id = ?
    )); LIMIT ? OFFSET ?;";
        $stmt = $db->query($sqlQuery, params: [$_info->user_id, $payload->max, $payload->current]);
    }


    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET MY INFO
$router->add('GET', '/master/users/myInfo', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $db = new Database();
    $sqlQuery = $db->generateDynamicQuery("users",  []). " WHERE user_id = ?";
    $stmt = $db->query($sqlQuery, [$_info->user_id]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
});


// CREATE NEW USER
$router->add('POST', '/master/users/new', function () {
    $pageID=4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    $requiredFields = ["mobile", "password", "first_name", "last_name"];
    $handler->validateInput($data, $requiredFields);

    $db = new Database();
    $db->pdo->beginTransaction();
    try {

        // check if mobile number already exists
        $stmt = $db->query("SELECT user_id FROM users WHERE mobile = ?", [$data["mobile"]]);

        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Mobile number already exists."))->toJson();
            return;
        }

        $stmt = $db->query(
            "INSERT INTO users (mobile, password, first_name, last_name, gender, birth_date, address, email, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING user_id",
            [$data["mobile"], $data["password"], $data["first_name"], $data["last_name"], $data["gender"], $data["birth_date"], $data["address"], $data["email"], $_info->user_id]
        );
        $user_id = $stmt->fetchColumn();

       
    } catch (Exception $e) {
        $db->pdo->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
    $db->pdo->commit();
    (new ApiResponse(200, "User created successfully.", $user_id))->toJson();
});

// DELETE USER
$router->add('POST', '/master/users/delete', function () {
    $pageID=4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data["user_id"]) || !is_numeric($data["user_id"])) {
        (new ApiResponse(400, "Invalid user ID."))->toJson();
        return;
    }

    $user_id = (int) $data["user_id"];
    $db = new Database();

    try {
        $db->beginTransaction();

        $stmt = $db->query("SELECT user_id FROM users WHERE user_id = ?", [$user_id]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "User not found."))->toJson();
            return;
        }
        $db->query("UPDATE users SET status = FALSE WHERE user_id = ?", [$user_id]);
        $db->commit();
        (new ApiResponse(200, "User deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// UPDATE DB 
$router->add('POST', '/master/users/update', function () {
    $pageID = 2;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u"); // "d" for delete permission

    $payload = (object) [
        "updates" => [],
        "conditions" => 'user_id=0'
    ];

    $data = json_decode(file_get_contents("php://input"), true);


    if (!empty($data)) {
        $payload = (object) $data;
    }
    
    $db = new Database();
    $sql = $db->generateDynamicUpdate("users", $payload->updates, $payload->conditions);
    try {
        $stmt = $db->query($sql[0], $sql[1]);

        if ($stmt->rowCount() > 0) {
            (new ApiResponse(200, "Update successful"))->toJson();
        } else {
            (new ApiResponse(500, "No rows updated"))->toJson();
        }
    } catch (Exception $e) {
        (new ApiResponse(500, "Update failed",  $e->getMessage()))->toJson();
    }
});
