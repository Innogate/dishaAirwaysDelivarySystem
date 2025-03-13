<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$pageID = 4;

$router->add('POST', '/master/users', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object) [
        "fields" => ["users.*", "user_info.*"],
        "max" => 10,
        "current" => 1,
        "relation" => "users.id=user_info.id",
    ];
    $handler->validatePermission($pageID, $_info->user_id, "r");
    
    $data = json_decode(file_get_contents("php://input"), true);
    
    if (!empty($data)) {
        $payload = (object) $data; 
    }
    

    
    $db = new Database();
    $sqlQuery = $db->generateDynamicQuery($payload->fields, $payload->relation);
    $sqlQuery = $sqlQuery . " WHERE status = TRUE LIMIT ? OFFSET ?";
    $stmt = $db->query ($sqlQuery, [$payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    
    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/users/new', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    $requiredFields = ["mobile", "password", "first_name", "last_name", "gender", "birth_date", "address", "email"];
    foreach ($requiredFields as $field) {
        if (!isset($data[$field]) || empty(trim($data[$field]))) {
            (new ApiResponse(400, "All fields are required."))->toJson();
            return;
        }
    }

    $db = new Database();
    
    try {
        
        $stmt = $db->query("SELECT id FROM users WHERE mobile = ?", [$data["mobile"]]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Mobile number already exists."))->toJson();
            return;
        }
        
        $stmt = $db->query("INSERT INTO users (mobile, password, created_by) VALUES (?, ?, ?) RETURNING id", 
            [$data["mobile"], $data["password"], $_info->user_id]
        );
        $user_id = $stmt->fetchColumn();

        $stmt = $db->query("INSERT INTO user_info (id, first_name, last_name, gender, birth_date, address, email, created_by) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
            [$user_id, $data["first_name"], $data["last_name"], $data["gender"], $data["birth_date"], 
             $data["address"], $data["email"], $_info->user_id]
        );
        
        $db->commit();
        (new ApiResponse(200, "User created successfully.", $user_id))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

$router->add('POST', '/master/users/delete', function () {
    global $pageID;
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
        
        $stmt = $db->query("SELECT id FROM users WHERE id = ?", [$user_id]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "User not found."))->toJson();
            return;
        }
        
        $db->query("DELETE FROM user_info WHERE id = ?", [$user_id]);
        $db->query("DELETE FROM users WHERE id = ?", [$user_id]);
        
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
        "updates" => [
            'talbe.name' => 'Error'
        ],
        "conditions" => [
            'talbe.id' => 0
        ]
    ];

    $data = json_decode(file_get_contents("php://input"), true);


    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicUpdate($payload->updates, $payload->conditions);

    // Debug: Print generated SQL query and parameters
    error_log("SQL Query: " . $sql["query"]);
    error_log("Parameters: " . json_encode($sql["params"]));

    try {
        $stmt = $db->query($sql["query"], $sql["params"]);

        if ($stmt->rowCount() > 0) {
            (new ApiResponse(200,"Update successful", $stmt->rowCount()))->toJson();
        } else {
            (new ApiResponse(500,"No rows updated"))->toJson();
        }
    } catch (Exception $e) {
        (new ApiResponse(500,"Update failed",  $e->getMessage()))->toJson();
    }
});
?>