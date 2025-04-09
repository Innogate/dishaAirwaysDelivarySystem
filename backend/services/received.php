<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;
$pageID = 1;

// GET RECEIVED BOOKINGS
$router->add('POST', '/booking/received', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, 'r');

    $payload = (object)[
        "max" => 10,
        "current" => 1
    ];

    if (empty($_info->branch_id)) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
    }

    $payload = (object)json_decode(file_get_contents("php://input"), true);
    
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;

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
        b.status,
        b.created_at AS booking_created_at,

        br.branch_id AS booking_branch_id,
        br.branch_name AS booking_branch_name,

        db.branch_id AS destination_branch_id,
        db.branch_name AS destination_branch_name,

        rb.id AS received_booking_id,
        rb.created_at AS received_booking_created_at,
        rb.status AS received_booking_status,

        rbr.branch_id AS received_branch_id,
        rbr.branch_name AS received_branch_name,

        c.city_name AS destination_city_name

    FROM bookings b
    JOIN received_booking rb ON b.booking_id = rb.booking_id
    JOIN branches br ON b.branch_id = br.branch_id
    JOIN branches db ON b.destination_branch_id = db.branch_id
    JOIN branches rbr ON rb.branch_id = rbr.branch_id
    JOIN cities c ON b.destination_city_id = c.city_id
    WHERE rb.branch_id = ? AND b.status = 5623
    ORDER BY rb.created_at DESC
    LIMIT $limit OFFSET $offset";


    $stmt = $db->query($sql, [$_info->branch_id]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
});


// ADD RECEIVED BOOKING
$router->add("POST", "/booking/received/new", function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    if (empty($_info->branch_id)) {
        (new ApiResponse(404, 'You are not logged into a branch account'))->toJson();
    }

    $data = json_decode(file_get_contents("php://input"), true);
    if (!is_array($data)) {
        (new ApiResponse(400, "Invalid input data"))->toJson();
    }

    $handler->validateInput($data, ["slip_no"]);
    $db = new Database();
    $db->beginTransaction();

    try {
        // Check if slip number exists
        $stmt = $db->query("SELECT booking_id, destination_branch_id FROM bookings WHERE slip_no = ?", [$data["slip_no"]]);
        $booking = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$booking) {
            throw new Exception("Invalid Slip No");
        }

        $booking_id = $booking["booking_id"];
        $destination_branch_id = $booking["destination_branch_id"];

        // Already received?
        $stmt = $db->query("SELECT 1 FROM received_booking WHERE booking_id = ? AND branch_id = ?", [$booking_id, $_info->branch_id]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            throw new Exception("Booking already received");
        }

        // If current branch is destination, mark as not pending
        $status = ($destination_branch_id != $_info->branch_id);

        // Check for tracking entry
        $stmt = $db->query("SELECT tracking_id FROM tracking WHERE booking_id = ? AND destination_branch_id = ?", [$booking_id, $_info->branch_id]);
        $tracking = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$tracking) {
            throw new Exception("Invalid Slip No - No matching tracking found");
        }

        $tracking_id = $tracking["tracking_id"];

        // Insert into received_booking
        $stmt = $db->query("INSERT INTO received_booking (booking_id, branch_id, status) VALUES (?, ?, ?)", [
            $booking_id, $_info->branch_id, (int)$status
        ]);
        if ($stmt->rowCount() === 0) {
            throw new Exception("Failed to insert received booking");
        }

        // Update tracking
        $stmt = $db->query("UPDATE tracking SET received = TRUE, arrived_at = NOW() WHERE tracking_id = ?", [$tracking_id]);
        if ($stmt->rowCount() === 0) {
            throw new Exception("Failed to update tracking status");
        }

        $db->commit();
        (new ApiResponse(200, "Success"))->toJson();

    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(400, $e->getMessage()))->toJson();
    }
});

?>
