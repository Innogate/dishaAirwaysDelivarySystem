<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    
    global $router;
    $router->add('GET', '/version', function () {
        echo json_encode(["version" => "0.0.1"]);
    });    
?>