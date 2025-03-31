<?php 
 require_once __DIR__ . '/../core/JwtHandler.php';
 require_once __DIR__ . '/../core/Database.php';
 
 global $router;
 $router->add('GET', '/verify', function () {
    $jwt = new JwtHandler();
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    $token = str_replace('Bearer ', '', $authHeader);
    
    if (!$token || !$jwt->verifyToken($token)) {
        $response = new ApiResponse(401, "Unauthorized access", $token);
        $response->toJson();
        exit;
    }
    else{
        $response = new ApiResponse(200, "Authorized access");
        $response->toJson();
        exit;
    }
 });    
?>