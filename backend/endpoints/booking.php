<?php 

use Firebase\JWT\JWT;
 require_once __DIR__ . '/../core/JwtHandler.php';
 require_once __DIR__ . '/../core/Database.php';
 
 global $router;
 $router->add('GET', '/booking', function () {
    $jwt = new JwtHandler();
    $_info = $jwt->validate();

    $pageID=1; // static id not chage that
    $db = new Database();
    $stmt = $db->query("SELECT permitioncode FROM permissions WHERE userid = ? AND pageid = ?", [$_info->user_id, $pageID]);
    $permition = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$permition) {
        $response = new ApiResponse(401,"Unauthorized access", "", 300);
        $response->toJson();
    }

    if ($permition['permitioncode'] != 11111 && $permition['permitioncode'] <= 1000) {
        $response = new ApiResponse(401,"Unauthorized access","", 301);
        $response->toJson();
    }
    
    // LOAD BRANCH ID WHARE Curent user work
    $stmt = $db->query("SELECT * FROM booking LIMIT 100");
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Scusess", $list);
    $response->toJson();
 });
 
//  fecth all data

?>