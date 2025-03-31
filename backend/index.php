<?php

require_once __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/config/config.php';
require_once __DIR__ . '/core/Router.php';
require_once __DIR__ . '/core/JwtHandler.php';
require_once __DIR__ . '/core/Database.php';
require_once __DIR__ . '/core/ApiResponse.php';

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$router = new Router();

// Load routes dynamically from endpoints folder
foreach (glob(__DIR__ . '/services/*.php') as $filename) {
    require_once $filename;
}

$router->resolve($_SERVER['REQUEST_URI'], $_SERVER['REQUEST_METHOD']);
?>