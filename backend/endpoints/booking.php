<?php 

 require_once __DIR__ . '/../core/JwtHandler.php';
 require_once __DIR__ . '/../core/Database.php';
 require_once __DIR__ .'/../core/Handler.php';
 global $router;
 global $pageID;
 $pageID=1;

 $router->add('GET', '/booking', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r"); // check user permit or not for this page
    
    $db = new Database();
    $stmt = $db->query("SELECT * FROM booking LIMIT 100");
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
 });
?>