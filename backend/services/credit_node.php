<?php 
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// ** GET ALL BRANCH TOKEN FOR BOOKING
$router->add('POST', '/credit/token', function () {
    $pageID = 9;
    $db = new Database();
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object)[
        "fields" => [],
        "max" => 10,
        "current" => 0,
    ];
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check permission
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, [ "max", "current" ]);

    $limit = (int) $payload->max;
    $offset = (int) $payload->current;

    $sql = "SELECT credit_node.*, branches.branch_name as branch_name, cities.city_name as city_name 
            FROM credit_node 
            JOIN branches ON credit_node.branch_id = branches.branch_id 
            JOIN cities ON branches.city_id = cities.city_id 
            LIMIT $limit OFFSET $offset";
    
    $stmt = $db->query($sql, [$limit]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
}); 

// ** GET TOKEN BY ID
$router->add("POST", "/credit/token/byId", function () {
    $pageID = 9;
    $db = new Database();
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["token_id"]);

    $sql = "SELECT * FROM credit_node WHERE credit_node_id = ?";
    $stmt = $db->query($sql, [$data["token_id"]]);
    $token = $stmt->fetch(PDO::FETCH_ASSOC) ?: null;

    (new ApiResponse(200, "Success", $token))->toJson();
});

// ** CREATE NEW TOKEN
$router->add("POST", "/credit/token/new", function () {
    $pageID = 9;
    $db = new Database();
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["branch_id", "start_no", "end_no"]);

    // Insert data
    $sql = "INSERT INTO credit_node (branch_id, start_no, end_no) VALUES (?, ?, ?)";
    $stmt = $db->query($sql, [$data["branch_id"], $data["start_no"], $data["end_no"]]);

    if (!$stmt) {
        (new ApiResponse(400, "Failed to create. Try again."))->toJson();
        return;
    }

    // Get last inserted ID (MariaDB-compatible)
    $lastId = $db->lastInsertId();

    (new ApiResponse(200, "Success", $lastId))->toJson();
});

// ** DELETE TOKEN
$router->add("POST", "/credit/token/delete", function () {
    $pageID = 9;
    $db = new Database();
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["token_id"]);

    // Check if token exists
    $sql = "SELECT * FROM credit_node WHERE credit_node_id = ?";
    $stmt = $db->query($sql, [$data["token_id"]]);
    $token = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$token) {
        (new ApiResponse(400, "Error", "Token Not Found"))->toJson();
        return;
    }

    // Delete token
    $sql = "DELETE FROM credit_node WHERE credit_node_id = ?";
    $stmt = $db->query($sql, [$data["token_id"]]);

    (new ApiResponse(200, "Success", "Token Deleted Successfully"))->toJson();
});
?>