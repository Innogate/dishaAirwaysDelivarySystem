<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';
global $router;
global $pageID;
$pageID = 1;

// GET RECEIVED BOOKING //? DONE
$router->add('POST', '/booking/received', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, 'r');

    if ($_info->branch_id == null || $isAdmin) {
        (new ApiResponse(404, 'You not login brach account'))->toJson();
    }

    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }


    $db = new Database();
    $sql = "SELECT 
    b.booking_id,
    b.slip_no,
    b.consignee_name,
    b.consignee_mobile,
    b.consignor_name,
    b.consignor_mobile,
    b.booking_address,
    b.transport_mode,
    b.paid_type,
    b.on_account,
    b.to_pay,
    b.cgst,
    b.sgst,
    b.igst,
    b.total_value,
    b.package_count,
    b.package_weight,
    b.package_value,
    b.package_contents,
    b.shipper_charges,
    b.created_at AS booking_created_at,

    -- Branch Details
    br.branch_id AS booking_branch_id,
    br.branch_name AS booking_branch_name,

    -- Destination Branch Details
    db.branch_id AS destination_branch_id,
    db.branch_name AS destination_branch_name,

    -- Received Booking Details
    rb.id AS received_booking_id,
    rb.created_at AS received_booking_created_at,
    rb.status AS received_booking_status,

    -- Receiving Branch Details
    rbr.branch_id AS received_branch_id,
    rbr.branch_name AS received_branch_name

FROM bookings b
JOIN received_booking rb ON b.booking_id = rb.booking_id
JOIN branches br ON b.branch_id = br.branch_id
JOIN branches db ON b.destination_branch_id = db.branch_id
JOIN branches rbr ON rb.branch_id = rbr.branch_id
WHERE rb.branch_id = ? AND NOT b.status = 5
ORDER BY rb.created_at DESC
LIMIT ? OFFSET ?;
";
    $stmt = $db->query($sql, [$_info->branch_id, $payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
});

//  ADD NEW RECEIVED BOOKING //? DONE
$router->add("POST", "/booking/received/new", function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    if ($_info->branch_id == null || $isAdmin) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
        exit;
    }

    $data = json_decode(file_get_contents("php://input"), true);
    if (!is_array($data)) {
        (new ApiResponse(400, "Invalid input data"))->toJson();
        exit;
    }

    $required_fields = ["slip_no"];
    $handler->validateInput($data, $required_fields);

    $db = new Database();
    $db->beginTransaction();

    try {
        $status = true;
        
        // Checking if slip_no is valid
        $sql = "SELECT booking_id, destination_branch_id FROM bookings WHERE slip_no = ?";
        $stmt = $db->query($sql, [$data["slip_no"]]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$result) {
            (new ApiResponse(404, "Invalid Slip No"))->toJson();
            exit;
        }

        $booking_id = $result["booking_id"];
        $destination_branch_id = $result["destination_branch_id"];

        // Check if booking ID already exists in received_booking
        $sql = "SELECT 1 FROM received_booking WHERE booking_id = ?";
        $stmt = $db->query($sql, [$booking_id]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(400, "Booking already received"))->toJson();
            exit;
        }

        // Validate if destination branch is the current branch
        if ($destination_branch_id == $_info->branch_id) {
            $status = false;
        }

        // Validate tracking entry for this branch
        $sql = "SELECT tracking_id FROM tracking WHERE booking_id = ? AND destination_branch_id = ?";
        $stmt = $db->query($sql, [$booking_id, $_info->branch_id]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$result) {
            (new ApiResponse(404, "Invalid Slip No"))->toJson();
            exit;
        }

        $tracking_id = $result["tracking_id"];

        // Insert into received_bookings
        $sql = "INSERT INTO received_booking (booking_id, branch_id, status) VALUES (?, ?, ?)";
        $stmt = $db->query($sql, [$booking_id, $_info->branch_id, (int) $status]);
        
        if ($stmt->rowCount() === 0) {
            (new ApiResponse(500, "Something went wrong during insertion"))->toJson();
            exit;
        }

        // Update tracking to mark received as true
        $sql = "UPDATE tracking SET received = TRUE, arrived_at = NOW() WHERE tracking_id = ?";
        $stmt = $db->query($sql, [$tracking_id]);
        
        if ($stmt->rowCount() === 0) {
            (new ApiResponse(500, "Something went wrong during tracking update"))->toJson();
            exit;
        }

        $db->commit();
        (new ApiResponse(200, "Success"))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(400, $e->getMessage()))->toJson();
    }
});

?>