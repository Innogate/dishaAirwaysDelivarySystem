<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ .'/../core/Handler.php';

    global $router;
    global $pageID;

    $pageID=2;
    $router->add('POST', '/master/states', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $data = json_decode(file_get_contents("php://input"), true);

        $db = new Database();
        $stmt = $db->query("SELECT * FROM states ORDER BY name ASC LIMIT 10 OFFSET ?", [$data["from"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$list) {
            $list = [];
        }

        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });

    $router->add('POST', '/master/states/byId', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $data = json_decode(file_get_contents("php://input"), true);

        $db = new Database();
        $stmt = $db->query("SELECT * FROM states WHERE id = ? LIMIT 10 OFFSET ?", [$data["state_id"], $data["from"]]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$list) {
            $list = [];
        }

        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });

    $router->add('POST', '/master/states/new', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "w");
        $data = json_decode(file_get_contents("php://input"), true);

        // Validate input
        if (!isset($data["state_name"]) || empty(trim($data["state_name"]))) {
            $response = new ApiResponse(400, "State name cannot be empty.");
            $response->toJson();
            return;
        }

        $db = new Database();

        // Normalize state name for checking (trim & lowercase)
        $normalizedStateName = strtolower(trim($data["state_name"]));

        // Check if the state already exists
        $stmt = $db->query("SELECT id FROM states WHERE LOWER(TRIM(name)) = ?", [$normalizedStateName]);
        $existingState = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($existingState) {
            $response = new ApiResponse(409, "State already exists.");
            $response->toJson();
            return;
        }

        // Insert with original user-provided state name
        $stmt = $db->query("INSERT INTO states (name, created_by) VALUES (?, ?) RETURNING id", [$data["state_name"], $_info->user_id]);
        $entry_id = $stmt->fetchColumn();

        $response = new ApiResponse(200, "Success", $entry_id);
        $response->toJson();
    });

    $router->add('POST', '/master/states/delete', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "d"); // "d" for delete permission
    
        $data = json_decode(file_get_contents("php://input"), true);
    
        // Validate input
        if (!isset($data["state_id"]) || !is_numeric($data["state_id"])) {
            $response = new ApiResponse(400, "Invalid state ID.");
            $response->toJson();
            return;
        }
    
        $state_id = (int) $data["state_id"];
    
        $db = new Database();
    
        // Check if the state exists
        $stmt = $db->query("SELECT id FROM states WHERE id = ?", [$state_id]);
        $existingState = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if (!$existingState) {
            $response = new ApiResponse(404, "State not found.");
            $response->toJson();
            return;
        }
    
        // Delete the state
        $stmt = $db->query("DELETE FROM states WHERE id = ?", [$state_id]);
    
        $response = new ApiResponse(200, "State deleted successfully.");
        $response->toJson();
    });
    

?>