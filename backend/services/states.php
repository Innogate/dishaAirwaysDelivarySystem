<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// GET ALL STATES
$router->add('POST', '/master/states', function () {
    $jwt = new JwtHandler(); $jwt->validate();
    $data = json_decode(file_get_contents("php://input"), true) ?: [];
    $max = $data["max"] ?? 10;
    $current = $data["current"] ?? 0;

    $db = new Database();
    $stmt = $db->query("SELECT * FROM states ORDER BY state_name ASC LIMIT ? OFFSET ?", [$max, $current]);
    (new ApiResponse(200, "Success", $stmt->fetchAll(PDO::FETCH_ASSOC) ?: []))->toJson();
});

// GET STATE BY ID
$router->add('POST', '/master/states/byId', function () {
    $jwt = new JwtHandler(); $handler = new Handler();
    $jwt->validate();
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["state_id"]);

    $db = new Database();
    $stmt = $db->query("SELECT * FROM states WHERE state_id = ?", [$data["state_id"]]);
    (new ApiResponse(200, "Success", $stmt->fetch(PDO::FETCH_ASSOC) ?: []))->toJson();
});

// CREATE NEW STATE
$router->add('POST', '/master/states/new', function () {
    $jwt = new JwtHandler(); $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission(2, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);
    $name = trim($data["state_name"] ?? "");

    if (!$name) return (new ApiResponse(400, "State name cannot be empty."))->toJson();

    $db = new Database();
    $stmt = $db->query("SELECT state_id FROM states WHERE LOWER(TRIM(state_name)) = ?", [strtolower($name)]);
    if ($stmt->fetch()) return (new ApiResponse(409, "State already exists."))->toJson();

    $db->query("INSERT INTO states (state_name) VALUES (?)", [$name]);
    $id = $db->lastInsertId();
    (new ApiResponse(200, "Success", $id))->toJson();
});

// DELETE STATE (Soft Delete)
$router->add('POST', '/master/states/delete', function () {
    $jwt = new JwtHandler(); $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission(2, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);
    $id = (int)($data["state_id"] ?? 0);

    if (!$id) return (new ApiResponse(400, "Invalid state ID."))->toJson();

    $db = new Database();
    $stmt = $db->query("SELECT state_id FROM states WHERE state_id = ?", [$id]);
    if (!$stmt->fetch()) return (new ApiResponse(404, "State not found."))->toJson();

    $db->query("UPDATE cities SET status = FALSE WHERE state_id = ?", [$id]);
    $db->query("UPDATE states SET status = FALSE WHERE state_id = ?", [$id]);

    (new ApiResponse(200, "State deleted successfully."))->toJson();
});

// UPDATE STATE
$router->add('POST', '/master/states/update', function () {
    $jwt = new JwtHandler(); $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission(2, $_info->user_id, "u");

    $data = json_decode(file_get_contents("php://input"), true);
    $updates = $data["updates"] ?? [];
    $conditions = $data["conditions"] ?? "";

    $db = new Database();
    $sql = $db->generateDynamicUpdate("states", $updates, $conditions);

    try {
        $stmt = $db->query($sql[0], $sql[1]);
        (new ApiResponse($stmt->rowCount() > 0 ? 200 : 500, $stmt->rowCount() > 0 ? "Update successful" : "No rows updated"))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});
?>
