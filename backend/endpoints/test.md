<?php
require_once __DIR__ . '/../core/JwtHandler.php';

header("Content-Type: application/json");

$jwt = new JwtHandler();
$authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
$token = str_replace('Bearer ', '', $authHeader);

if (!$token || !$jwt->verifyToken($token)) {
    http_response_code(401);
    echo json_encode(["error" => "Unauthorized access"]);
    exit;
}

$input = json_decode(file_get_contents("php://input"), true);
if (!isset($input['number'])) {
    http_response_code(400);
    echo json_encode(["error" => "Missing 'number' parameter"]);
    exit;
}

$number = $input['number'];
$square = $number * $number;

echo json_encode(["number" => $number, "square" => $square]);
?>