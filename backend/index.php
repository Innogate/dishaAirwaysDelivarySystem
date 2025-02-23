<?php 
// index.php - Main entry point
require_once __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/config/config.php';
require_once __DIR__ . '/core/Router.php';
require_once __DIR__ . '/core/JwtHandler.php';
require_once __DIR__ . '/core/Database.php';
require_once __DIR__ . '/core/ApiResponse.php';

$router = new Router();

// Load routes dynamically from endpoints folder
foreach (glob(__DIR__ . '/endpoints/*.php') as $filename) {
    require_once $filename;
}

$router->resolve($_SERVER['REQUEST_URI'], $_SERVER['REQUEST_METHOD']);
?>