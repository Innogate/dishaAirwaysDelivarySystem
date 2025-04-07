<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// Get list of cities with pagination
$router->add('POST', '/master/cities', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 1
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data; 
    }
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;
    $db = new Database();
    $offset = ($payload->current - 1) * $payload->max;
    $sql = $db->generateDynamicQuery("cities", $payload->fields) . " WHERE status = 1 ORDER BY city_name ASC LIMIT $limit OFFSET $offset";
    $stmt = $db->query($sql);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});

// Get city by id
$router->add('POST', '/master/cities/byId', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $payload = (object) [
        "fields" => [],
        "city_id" => 0
    ];
    $data = json_decode(file_get_contents("php://input"), true);

    if (!empty($data)) {
        $payload = (object) $data; 
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery("cities", $payload->fields) . " WHERE city_id = ?";
    $stmt = $db->query($sql, [$payload->city_id]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$list) {
        $response = new ApiResponse(400, "Invalid City ID");
        $response->toJson();
        return;
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});

// Get cities by state id
$router->add('POST', '/master/cities/byStateId', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 1,
        "state_id" => 0
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data; 
    }
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;
    $db = new Database();
    $offset = ($payload->current - 1) * $payload->max;
    $sql = $db->generateDynamicQuery("cities", $payload->fields) . " WHERE state_id = ? AND status = 1 ORDER BY city_name ASC LIMIT $limit OFFSET $offset";
    $stmt = $db->query($sql, [$payload->state_id]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});

// Add a new city
$router->add('POST', '/master/cities/new', function () {
    $pageID = 3;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    // Validate input
    if (!isset($data["city_name"]) || !isset($data["state_id"]) || empty(trim($data["city_name"])) || !is_numeric($data["state_id"])) {
        $response = new ApiResponse(400, "Invalid city name or state ID.");
        $response->toJson();
        return;
    }

    $db = new Database();

    // Check if the state ID exists
    $stmt = $db->query("SELECT state_id FROM states WHERE state_id = ?", [$data["state_id"]]);
    $existingState = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$existingState) {
        $response = new ApiResponse(404, "State ID not found.");
        $response->toJson();
        return;
    }

    // Normalize city name for checking (trim & lowercase)
    $normalizedCityName = strtolower(trim($data["city_name"]));

    // Check if the city already exists in the same state
    $stmt = $db->query("SELECT city_id FROM cities WHERE LOWER(TRIM(city_name)) = ? AND state_id = ?", [$normalizedCityName, $data["state_id"]]);
    $existingCity = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($existingCity) {
        $response = new ApiResponse(409, "City already exists in this state.");
        $response->toJson();
        return;
    }

    // Insert with original user-provided city name
    $stmt = $db->query("INSERT INTO cities (city_name, state_id) VALUES (?, ?)", [$data["city_name"], $data["state_id"]]);
    $entry_id = $db->lastInsertId();

    $response = new ApiResponse(200, "Success", $entry_id);
    $response->toJson();
});

// Delete a city by ID (Soft Delete)
$router->add('POST', '/master/cities/delete', function () {
    $pageID = 3;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);

    // Validate input
    if (!isset($data["city_id"]) || !is_numeric($data["city_id"])) {
        $response = new ApiResponse(400, "Invalid city ID.");
        $response->toJson();
        return;
    }

    $db = new Database();

    // Check if the city exists and is not already deleted
    $stmt = $db->query("SELECT city_id FROM cities WHERE city_id = ? AND status = 1", [$data["city_id"]]);
    $city = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$city) {
        $response = new ApiResponse(404, "City not found or already deleted.");
        $response->toJson();
        return;
    }

    // Soft delete the city
    $stmt = $db->query("UPDATE cities SET status = 0 WHERE city_id = ?", [$data["city_id"]]);

    $response = new ApiResponse(200, "City deleted successfully.");
    $response->toJson();
});
