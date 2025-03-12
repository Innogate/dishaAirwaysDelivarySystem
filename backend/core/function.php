<?php
 function validate()  {
    $jwt = new JwtHandler();
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    $token = str_replace('Bearer ', '', $authHeader);
    $_info = $jwt->verifyToken($token);
    if (!$token || !$_info) {
        $response = new ApiResponse(401, "Unauthorized access", "", error_code: 101);
        $response->toJson();
        exit;
    }
 }
 
?>