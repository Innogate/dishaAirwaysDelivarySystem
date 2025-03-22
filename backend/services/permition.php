<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// GET access
$router->add('POST', '/master/access/userId', function () {
    $pageID = 8;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");
    $data = json_decode(file_get_contents("php://input"), true);
    $require_field = ["user_id"];
    $handler->validateInput($data, $require_field);


    $db = new Database();
    $sql = "SELECT * FROM permissions WHERE user_id = ?";
    $stmt = $db->query($sql, [$data["user_id"]]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/access', function () {
    $pageID = 8;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
   


    $db = new Database();
    $sql = "SELECT * FROM permissions WHERE user_id = ?";
    $stmt = $db->query($sql, [$_info->user_id]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/access/update', function () {
    $pageID = 8;
    $jwt = new JwtHandler();
    $handler = new Handler();
    
    // Validate JWT token
    $_info = $jwt->validate();
    
    // Validate user permission for the page
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, 'u');
    
    // Required fields for input validation
    $require_field = ['user_id', 'permission_code', 'page_id'];
    
    // Get input data
    $data = json_decode(file_get_contents("php://input"), true);
    
    // Validate input data
    $handler->validateInput($data, $require_field);

    // Check if the user is an admin
    if (!$isAdmin && $_info->user_id != null) {
        // split down the permission code into an array
        $permission_code = explode(',', $data['permission_code']);
        // check ;ast digit 1 or not 
        if (end($permission_code) == '1') {
            (new ApiResponse(403, "You don't have permission to perform this action"))->toJson();
        }
    }

    // Connect to the database
    $db = new Database();
    
    // Check if the user already has access to the requested page
    $sqlCheck = "SELECT * FROM permissions WHERE user_id = ? AND page_id = ?";
    $stmtCheck = $db->query($sqlCheck, [$data['user_id'], $data['page_id']]);
    $existingPermission = $stmtCheck->fetch(PDO::FETCH_ASSOC);
    
    if ($existingPermission) {
        // User has access, so update the record
        $sqlUpdate = "UPDATE permissions SET permission_code = ? WHERE user_id = ? AND page_id = ?";
        $db->query($sqlUpdate, [$data['permission_code'], $data['user_id'], $data['page_id']]);
        $message = "Permission updated successfully";
    } else {
        // User doesn't have access, so insert a new record
        $sqlInsert = "INSERT INTO permissions (user_id, permission_code, page_id) VALUES (?, ?, ?)";
        $db->query($sqlInsert, [$data['user_id'], $data['permission_code'], $data['page_id']]);
        $message = "Permission granted successfully";
    }

    // Send a success response
    (new ApiResponse(200, $message, []))->toJson();
});


$router->add("GET","/master/pages", function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    
    $db = new Database();
    $sql = "SELECT * FROM pages";
    $stmt = $db->query($sql);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
})
?>