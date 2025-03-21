<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ .'/../core/Handler.php';

    global $router;
    // Get list of cities with pagination
    $router->add('POST', '/master/cities', function () {
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $payload = (object) [
            "fields" => ["cities.*"],
            "max" => 10,
            "current" => 1,
            "relation" => null,
        ];
        $data = json_decode(file_get_contents("php://input"), true);
        if (!empty($data)) {
            $payload = (object) $data; 
        }

        $db = new Database();
        $sql = $db->generateDynamicQuery($payload->fields, $payload->relation)." WHERE status = TRUE ORDER BY city_name ASC LIMIT ? OFFSET ?";
        $stmt = $db->query($sql, [$payload->max, $payload->current]);
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

        $payload = (object) [
            "fields" => ["cities.*"],
            "max" => 10,
            "city_id" => 0,
            "current" => 1,
            "relation" => null,
        ];
        $data = json_decode(file_get_contents("php://input"), true);

        if (!empty($data)) {
            $payload = (object) $data; 
        }

        $db = new Database();
        $sql = $db->generateDynamicQuery($payload->fields, $payload->relation)." WHERE state_id = ?";
        $stmt = $db->query($sql, [$payload->city_id]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$list) {
            $response = new ApiResponse(400, "Invalid City ID", "", 400);
            $response->toJson();
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
            "fields" => ["cities.*"],
            "max" => 10,
            "current" => 1,
            "relation" => null,
            "state_id" => 0
        ];
        $data = json_decode(file_get_contents("php://input"), true);
        if (!empty($data)) {
            $payload = (object) $data; 
        }

        $db = new Database();
        $sql = $db->generateDynamicQuery($payload->fields, $payload->relation)." WHERE state_id = ? AND status = TRUE ORDER BY city_name ASC LIMIT ? OFFSET ?";
        $stmt = $db->query($sql, [$payload->state_id, $payload->max, $payload->current]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);;
        if (!$list) {
            $list = [];
        }

        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });

    // Add a new city
    $router->add('POST', '/master/cities/new', function () {
        $pageID=3;
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
        $stmt = $db->query("INSERT INTO cities (city_name, state_id) VALUES (?, ?) RETURNING city_id", [$data["city_name"], $data["state_id"]]);
        $entry_id = $stmt->fetchColumn();
    
        $response = new ApiResponse(200, "Success", $entry_id);
        $response->toJson();
    });
    

    // Delete a city by ID
    $router->add('POST', '/master/cities/delete', function () {
        $pageID=3;
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
        $stmt = $db->query("SELECT city_id FROM cities WHERE city_id = ?", [$city_id]);
        $existingCity = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$existingCity) {
            $response = new ApiResponse(404, "City not found.");
            $response->toJson();
            return;
        }

        // Delete the city
        $stmt = $db->query("UPDATE cities SET status = FALSE WHERE city_id = ?", [$city_id]);

        $response = new ApiResponse(200, "City deleted successfully.");
        $response->toJson();
    });

    // UPDATE DB 
    $router->add('POST', '/master/cities/update', function () {
        $pageID = 3;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "u"); // "d" for delete permission
    
        $payload = (object) [
            "updates" => [
                'cities.city_name' => 'Error'
            ],
            "conditions" => [
                'cities.city_id' => 0
            ]
        ];
    
        $data = json_decode(file_get_contents("php://input"), true);
    
    
        if (!empty($data)) {
            $payload = (object) $data;
        }
    
        $db = new Database();
        $sql = $db->generateDynamicUpdate($payload->updates, $payload->conditions);
    
        // Debug: Print generated SQL query and parameters
        error_log("SQL Query: " . $sql["query"]);
        error_log("Parameters: " . json_encode($sql["params"]));
    
        try {
            $stmt = $db->query($sql["query"], $sql["params"]);
    
            if ($stmt->rowCount() > 0) {
                (new ApiResponse(200,"Update successful", $stmt->rowCount()))->toJson();
            } else {
                (new ApiResponse(500,"No rows updated"))->toJson();
            }
        } catch (Exception $e) {
            (new ApiResponse(500,"Update failed",  $e->getMessage()))->toJson();
        }
    
    
    
    })
?>
