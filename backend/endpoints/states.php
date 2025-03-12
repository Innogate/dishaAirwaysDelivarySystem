<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$pageID = 2;
$router->add('POST', '/master/states', function () {
    $pageID = 2;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object) [
        "fields" => ["states.*"],
        "max" => 10,
        "current" => 1,
        "relation" => null,
    ];
    $data = json_decode(file_get_contents("php://input"), true);

    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE status = TRUE ORDER BY name ASC LIMIT ? OFFSET ?";

    $stmt = $db->query($sql, [$payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});

$router->add('POST', '/master/states/byId', function () {
    $pageID = 2;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $payload = (object) [
        "fields" => ["states.*"],
        "max" => 10,
        "current" => 1,
        "state_id" => 0,
        "relation" => null,
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE id = ?";
    $stmt = $db->query($sql, [$data["state_id"]]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});

// CREATE NEW STATE
$router->add('POST', '/master/states/new', function () {
    $pageID = 2;
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
    $stmt = $db->query("INSERT INTO states (name) VALUES (?) RETURNING id", [$data["state_name"]]);
    $entry_id = $stmt->fetchColumn();

    $response = new ApiResponse(200, "Success", $entry_id);
    $response->toJson();
});

// DELETE STATE
$router->add('POST', '/master/states/delete', function () {
    $pageID = 2;
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

    // DELETE ALL CITIFIES ASSOCIATED WITH STATE
    $stmt = $db->query("UPDATE cities SET status=FALSE WHERE state_id = ?", [$state_id]);

    // Delete the state
    $stmt = $db->query("UPDATE states SET status=FALSE  WHERE id = ?", [$state_id]);


    $response = new ApiResponse(200, "State deleted successfully.");
    $response->toJson();
});

// UPDATE STATES
$router->add('POST', '/master/states/update', function () {
    $pageID = 2;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u"); // "d" for delete permission

    $payload = (object) [
        "updates" => [
            'sates.name' => 'Error'
        ],
        "conditions" => [
            'users.id' => 0
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