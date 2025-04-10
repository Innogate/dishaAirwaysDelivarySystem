<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$pageID = 4;

// GET USERS
$router->add('POST', '/master/users', function () {
    $pageID = 4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object)[
        "fields" => [],
        "max" => 10,
        "current" => 1
    ];
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object)$data;
    }

    $db = new Database();
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;


    if ($isAdmin && $_info->branch_id === null) {
        $sqlQuery = "SELECT 
            u.*,
            COALESCE(bu.branch_id, r.branch_id) AS branch_id,
            b.branch_name,
            bu.branch_id AS branch_from_branch_user,
            r.branch_id AS branch_from_representatives
        FROM users u
        LEFT JOIN branch_user bu ON u.user_id = bu.user_id
        LEFT JOIN representatives r ON u.user_id = r.user_id
        LEFT JOIN branches b ON b.branch_id = COALESCE(bu.branch_id, r.branch_id)
        LIMIT $limit OFFSET $offset";
        $stmt = $db->query($sqlQuery);
    } else {
        $sqlQuery = "SELECT * FROM users WHERE created_by IN (
            SELECT user_id FROM representatives 
            WHERE branch_id = (
                SELECT branch_id FROM representatives 
                WHERE user_id = ?
            )
        ) AND status = TRUE ORDER BY created_at LIMIT $limit OFFSET $offset";
        $stmt = $db->query($sqlQuery, [$_info->user_id]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET DELETED USERS
$router->add('POST', '/master/users/deleted', function () {
    $pageID = 4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object)[
        "fields" => [],
        "max" => 10,
        "current" => 1
    ];
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object)$data;
    }

    $db = new Database();
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;
    $sqlQuery = $db->generateDynamicQuery("users", $payload->fields);

    if ($isAdmin && $_info->branch_id === null) {
        $sqlQuery .= " WHERE status = FALSE ORDER BY first_name LIMIT $limit OFFSET $offset";
        $stmt = $db->query($sqlQuery);
    } else {
        $sqlQuery .= " WHERE created_by IN (
            SELECT user_id FROM representatives 
            WHERE branch_id = (
                SELECT branch_id FROM representatives 
                WHERE user_id = ?
            )
        ) AND status = FALSE ORDER BY first_name LIMIT $limit OFFSET $offset";
        $stmt = $db->query($sqlQuery, [$_info->user_id]);
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
    $sqlQuery = $db->generateDynamicQuery("users", []) . " WHERE user_id = ?";
    $stmt = $db->query($sqlQuery, [$_info->user_id]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
});

// CREATE USER
$router->add('POST', '/master/users/new', function () {
    $pageID = 4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);
    $requiredFields = ["mobile", "password", "first_name", "last_name"];
    $handler->validateInput($data, $requiredFields);

    $db = new Database();
    $db->pdo->beginTransaction();
    try {
        $stmt = $db->query("SELECT user_id FROM users WHERE mobile = ?", [$data["mobile"]]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Mobile number already exists."))->toJson();
            return;
        }

        $db->query(
            "INSERT INTO users (mobile, password, first_name, last_name, gender, birth_date, address, email, created_by)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [$data["mobile"], $data["password"], $data["first_name"], $data["last_name"], $data["gender"], $data["birth_date"], $data["address"], $data["email"], $_info->user_id]
        );
        $user_id = $db->pdo->lastInsertId();

        if (!$isAdmin && $_info->branch_id !== null) {
            $db->query(
                "INSERT INTO branch_user (branch_id, user_id) VALUES (?, ?)",
                [$_info->branch_id, $user_id]
            );
        }

        $db->pdo->commit();
        (new ApiResponse(200, "User created successfully.", $user_id))->toJson();
    } catch (Exception $e) {
        $db->pdo->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// DELETE USER
$router->add('POST', '/master/users/delete', function () {
    $pageID = 4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);
    if (!isset($data["user_id"]) || !is_numeric($data["user_id"])) {
        (new ApiResponse(400, "Invalid user ID."))->toJson();
        return;
    }

    $user_id = (int)$data["user_id"];
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

// UPDATE USER
$router->add('POST', '/master/users/update', function () {
    $pageID = 4;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u");

    $payload = (object)[
        "updates" => [],
        "conditions" => 'user_id=0'
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object)$data;
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
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});
