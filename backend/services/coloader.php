<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// Get list of coloaders with pagination
$router->add('POST', '/master/coloader', function () {
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

    $db = new Database();
    $sql = $db->generateDynamicQuery("coloader", $payload->fields) . " WHERE coloader_branch = ? ORDER BY coloader_city ASC LIMIT ? OFFSET ?";
    $stmt = $db->query($sql, [$_info->branch_id, $payload->max, ($payload->current - 1) * $payload->max]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $response = new ApiResponse(200, "Success", $list ?: []);
    $response->toJson();
});

// Add a new coloader
$router->add('POST', '/master/coloader/new', function () {
    $pageID = 10;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);
    $requiredFields = ["coloader_name", "coloader_contact", "coloader_address", "coloader_postal_code", "coloader_email", "coloader_city"];
    $handler->validateInput($data, $requiredFields);

    if ($isAdmin) {
        (new ApiResponse(403, "Only branch admin can create a coloader"))->toJson();
        return;
    }

    $db = new Database();
    $stmt = $db->query("INSERT INTO coloader (coloader_name, coloader_contact, coloader_address, coloader_postal_code, coloader_email, coloader_city, coloader_branch) VALUES (?, ?, ?, ?, ?, ?, ?)", [
        $data["coloader_name"],
        $data["coloader_contact"],
        $data["coloader_address"],
        $data["coloader_postal_code"],
        $data["coloader_email"],
        $data["coloader_city"],
        $_info->branch_id
    ]);

    if ($stmt) {
        (new ApiResponse(200, "Coloader created successfully"))->toJson();
    } else {
        (new ApiResponse(500, "Failed to create coloader"))->toJson();
    }
});

// Delete a coloader by ID
$router->add('POST', '/master/coloader/delete', function () {
    $pageID = 10;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data["coloader_id"]) || !is_numeric($data["coloader_id"])) {
        (new ApiResponse(400, "Invalid coloader ID"))->toJson();
        return;
    }

    $db = new Database();
    $stmt = $db->query("DELETE FROM coloader WHERE coloader_id = ?", [$data["coloader_id"]]);

    if ($stmt && $stmt->rowCount() > 0) {
        (new ApiResponse(200, "Coloader deleted successfully"))->toJson();
    } else {
        (new ApiResponse(404, "Coloader not found or already deleted"))->toJson();
    }
});

// Update coloader
$router->add('POST', '/master/coloader/update', function () {
    $pageID = 10;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u");

    $payload = (object) [
        "updates" => [],
        "conditions" => ""
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    if (empty($payload->updates) || empty($payload->conditions)) {
        (new ApiResponse(400, "Invalid update payload"))->toJson();
        return;
    }

    $db = new Database();
    try {
        $sql = $db->generateDynamicUpdate("coloader", $payload->updates, $payload->conditions);
        $stmt = $db->query($sql[0], $sql[1]);

        if ($stmt->rowCount() > 0) {
            (new ApiResponse(200, "Update successful", $stmt->rowCount()))->toJson();
        } else {
            (new ApiResponse(400, "No rows were updated"))->toJson();
        }
    } catch (Exception $e) {
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});
