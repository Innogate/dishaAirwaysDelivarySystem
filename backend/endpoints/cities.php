<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ .'/../core/Handler.php';

    global $router;
    global $pageID;

    $pageID = 3; // Assuming a different page ID for cities

    // Get list of cities with pagination
    $router->add('POST', '/master/cities', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $data = json_decode(file_get_contents("php://input"), true);

        $db = new Database();
        $stmt = $db->query("SELECT * FROM cities LIMIT 10 OFFSET ?", [$data["from"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);;
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

        $data = json_decode(file_get_contents("php://input"), true);

        if(!isset($data["city_id"])){
            (new ApiResponse(400,"city_id require", $data))->toJson();
        }

        $db = new Database();
        $stmt = $db->query("SELECT * FROM cities WHERE id = ?", [$data["city_id"]]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$list) {
            $response = new ApiResponse(400, "Invalid City ID", "", 400);
            $response->toJson();
        }

        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });

    $router->add('POST', '/master/cities/byStateId', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();

        $data = json_decode(file_get_contents("php://input"), true);

        $db = new Database();
        $stmt = $db->query("SELECT * FROM cities WHERE state_id = ? LIMIT 10 OFFSET ?", [$data["state_id"], $data["from"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);;
        if (!$list) {
            $list = [];
        }

        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });

    // Add a new city
    $router->add('POST', '/master/cities/new', function () {
        global $pageID;
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
        $stmt = $db->query("SELECT id FROM states WHERE id = ?", [$data["state_id"]]);
        $existingState = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if (!$existingState) {
            $response = new ApiResponse(404, "State ID not found.");
            $response->toJson();
            return;
        }
    
        // Normalize city name for checking (trim & lowercase)
        $normalizedCityName = strtolower(trim($data["city_name"]));
    
        // Check if the city already exists in the same state
        $stmt = $db->query("SELECT id FROM cities WHERE LOWER(TRIM(name)) = ? AND state_id = ?", [$normalizedCityName, $data["state_id"]]);
        $existingCity = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if ($existingCity) {
            $response = new ApiResponse(409, "City already exists in this state.");
            $response->toJson();
            return;
        }
    
        // Insert with original user-provided city name
        $stmt = $db->query("INSERT INTO cities (name, state_id, created_by) VALUES (?, ?, ?) RETURNING id", [$data["city_name"], $data["state_id"], $_info->user_id]);
        $entry_id = $stmt->fetchColumn();
    
        $response = new ApiResponse(200, "Success", $entry_id);
        $response->toJson();
    });
    

    // Delete a city by ID
    $router->add('POST', '/master/cities/delete', function () {
        global $pageID;
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

        $city_id = (int) $data["city_id"];

        $db = new Database();

        // Check if the city exists
        $stmt = $db->query("SELECT id FROM cities WHERE id = ?", [$city_id]);
        $existingCity = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$existingCity) {
            $response = new ApiResponse(404, "City not found.");
            $response->toJson();
            return;
        }

        // Delete the city
        $stmt = $db->query("DELETE FROM cities WHERE id = ?", [$city_id]);

        $response = new ApiResponse(200, "City deleted successfully.");
        $response->toJson();
    });

?>
