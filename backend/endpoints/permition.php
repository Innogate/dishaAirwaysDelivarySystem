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
    $_info = $jwt->validate();
    $_info = $jwt->validate();

    $handler->validatePermission($pageID,$_info->user_id, 'u');
    $require_field = ['user_id','permission_code','page_id'];
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, $require_field);
    $db = new Database();
    $sql = "UPDATE permissions SET permission_code = ?, page_id = ? WHERE user_id = ?";
    $stmt = $db->query($sql, [$data['permission_code'], $data['page_id'], $data['user_id']]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
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