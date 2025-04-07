<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

/**
 * Get permissions for a specific user by user ID
 */
$router->add('POST', '/master/access/userId', function () {
    $pageID = 8;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ['user_id']);

    $db = new Database();
    $sql = "SELECT * FROM permissions 
            JOIN pages ON permissions.page_id = pages.page_id 
            WHERE permissions.user_id = ?";
    $stmt = $db->query($sql, [$data["user_id"]]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

/**
 * Get permissions for the logged-in user
 */
$router->add('POST', '/master/access', function () {
    $pageID = 8;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $db = new Database();
    $sql = "SELECT * FROM permissions WHERE user_id = ?";
    $stmt = $db->query($sql, [$_info->user_id]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

/**
 * Update or insert permissions for a user
 */
$router->add('POST', '/master/access/update', function () {
    $pageID = 8;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, 'u');
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ['user_id', 'permission_code', 'page_id']);

    if (!$isAdmin && $_info->user_id != null) {
        $permission_code = explode(',', $data['permission_code']);
        if (end($permission_code) === '1') {
            (new ApiResponse(403, "You don't have permission to perform this action"))->toJson();
        }
    }

    $db = new Database();

    // Check for existing permission
    $sqlCheck = "SELECT * FROM permissions WHERE user_id = ? AND page_id = ?";
    $stmtCheck = $db->query($sqlCheck, [$data['user_id'], $data['page_id']]);
    $existingPermission = $stmtCheck->fetch(PDO::FETCH_ASSOC);

    if ($existingPermission) {
        // Update existing
        $sqlUpdate = "UPDATE permissions SET permission_code = ? 
                      WHERE user_id = ? AND page_id = ?";
        $db->query($sqlUpdate, [$data['permission_code'], $data['user_id'], $data['page_id']]);
        $message = "Permission updated successfully";
    } else {
        // Insert new
        $sqlInsert = "INSERT INTO permissions (user_id, permission_code, page_id, created_by) 
                      VALUES (?, ?, ?, ?)";
        $db->query($sqlInsert, [$data['user_id'], $data['permission_code'], $data['page_id'], $_info->user_id]);
        $message = "Permission granted successfully";
    }

    (new ApiResponse(200, $message))->toJson();
});

/**
 * Get all pages
 */
$router->add('GET', '/master/pages', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $db = new Database();
    $sql = "SELECT * FROM pages";
    $stmt = $db->query($sql);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});
