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

    $sql = "SELECT * FROM delivery_list WHERE branch_id = ? AND employee_id IS NOT NULL ORDER BY created_at DESC LIMIT $limit OFFSET $offset";
    $stmt = $db->query($sql, [$_info->branch_id]);

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
    $required_filed = ["employee_id", "booking_lists"];
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, $required_filed);

    if ($isAdmin || $_info->branch_id === null) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
        exit;
    }

    if (!isset($data['employee_id']) || !is_array($data['booking_lists'])) {
        (new ApiResponse(400, "Invalid input data"))->toJson();
        exit;
    }

    $booking_ids = $data['booking_lists'];
    if (empty($booking_ids)) {
        (new ApiResponse(400, "Booking list is empty"))->toJson();
        exit;
    }

    // Build placeholders like (?, ?, ?)
    $placeholders = implode(',', array_fill(0, count($booking_ids), '?'));
    $params = array_merge([$data['employee_id']], $booking_ids);

    $sql = "UPDATE delivery_list SET employee_id = ? WHERE booking_id IN ($placeholders)";

    $db = new Database();
    $db->query($sql, $params);

    $sql = "UPDATE bookings SET status = 2 WHERE booking_id IN ($placeholders)";
    $db->query($sql, $booking_ids);

    // Run loop booking_ids take one by on as booking_id
    foreach ($booking_ids as $booking_id) {
        $db->query("INSERT INTO tracking (current_branch_id, destination_branch_id, booking_id, departed_at)
                        VALUES (?, ?, ?, NOW())", [$_info->branch_id, 0, $booking_id]);
    }

    (new ApiResponse(200, "Delivery entries created successfully"))->toJson();
});


// ADD DELIVERY
$router->add("POST", "/delivery/new/booking", function () {
    $pageID = 12;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");
    $require_filed = ["booking_id"];

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, $require_filed);

    if($isAdmin || $_info->branch_id == null){
        (new ApiResponse(200,"You not logins in branch account"))->toJson();
    }

    $db = new Database();

    // check booking exist or not
    $sql = "SELECT b.booking_id FROM bookings as b JOIN received_booking as rb ON  b.booking_id = rb.booking_id  WHERE b.status != 6 AND b.booking_id = ? AND rb.branch_id = ? LIMIT 1";
    $stmt = $db->query($sql, [$data["booking_id"], $_info->branch_id]);
    $booking = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$booking) {
        (new ApiResponse(404, "Invalid booking no"))->toJson();
        exit;
    }

    $sql = "INSERT INTO delivery_list(booking_id, branch_id, created_by) VALUES (? , ?, ?);";
    $db->query($sql, [$booking["booking_id"], $_info->branch_id, $_info->user_id]);
    if($db->lastInsertId() > 0){
        (new ApiResponse(200,"Booking added for delivery"))->toJson();
    }
    (new ApiResponse(200,"Something went roang pls try again."))->toJson();
});

// LIST OFF BOOKING
$router->add("GET", "/delivery/new/list", function () {
    $pageID = 12;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");


    $db = new Database();
    if ($isAdmin && $_info->branch_id == null) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
        exit;
    }

    $sql = "SELECT * FROM delivery_list JOIN bookings ON delivery_list.booking_id = bookings.booking_id WHERE delivery_list.branch_id = ? AND delivery_list.employee_id IS NULL ORDER BY delivery_list.created_at DESC";
    $stmt = $db->query($sql, [$_info->branch_id]);

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();

});
?>
