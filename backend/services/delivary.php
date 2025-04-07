<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// GET ALL DELIVERIES
$router->add('POST', '/delivery', function () {
    $pageID = 12;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    $payload = (object)[
        "max" => 10,
        "current" => 0
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $limit = intval($payload->max);
    $offset = intval($payload->current);

    $db = new Database();
    if ($isAdmin && $_info->branch_id == null) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
        exit;
    }

    $sql = "SELECT * FROM delivery_list WHERE branch_id = ? ORDER BY created_at DESC LIMIT ? OFFSET ?";
    $stmt = $db->query($sql, [$_info->branch_id, $limit, $offset]);

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

// ENTRY NEW DELIVERY
$router->add('POST', '/delivery/new', function () {
    $pageID = 12;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    if (!$isAdmin || $_info->branch_id === null) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
        exit;
    }

    if (!isset($data['employee_id']) || !is_array($data['booking_list'])) {
        (new ApiResponse(400, "Invalid input data"))->toJson();
        exit;
    }

    $db = new Database();

    foreach ($data['booking_list'] as $booking_id) {
        $sql = "INSERT INTO delivery_list (booking_id, branch_id, employee_id, created_by, name)
                VALUES (?, ?, ?, ?, ?)";
        $bookingName = "Booking #$booking_id";
        $db->query($sql, [
            $booking_id,
            $_info->branch_id,
            $data['employee_id'],
            $_info->user_id,
            $bookingName
        ]);
    }

    (new ApiResponse(200, "Delivery entries created successfully"))->toJson();
});
?>
