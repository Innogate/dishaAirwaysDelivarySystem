<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

// GET BY SLIP ID
$router->add("POST", '/api/status/booking', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    // $_info = $jwt->validate();

    $data = json_decode(file_get_contents("php://input"), true);
    $required_fields = ["slip_no"];
    $handler->validateInput($data, $required_fields);

    $db = new Database();

    // GET BOOKING ID BY SLIP ID
    $sql = "SELECT 
                    consignee_name,
                    consignor_name,
                    slip_no,
                    package_count,
                    package_weight,
                    booking_address,
                    paid_type,
                    total_value,
                    created_at AS booking_date,
                    booking_id
                FROM bookings
                WHERE slip_no = ? AND NOT status = 4";
    $stmt = $db->query($sql, [$data["slip_no"]]);
    $booking = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$booking) {
        $response = new ApiResponse(404, "Invalid Slip No");
        $response->toJson();
        exit;
    }

    $booking_id = $booking["booking_id"];

    // Get tracking details
    $sql = "SELECT 
            received,
            arrived_at,
            departed_at,
            b.branch_name AS source_branch_name,
            bb.branch_name AS destination_branch_name
        FROM tracking t
        JOIN branches b ON t.current_branch_id = b.branch_id
        LEFT JOIN branches bb ON t.destination_branch_id = bb.branch_id
        WHERE t.booking_id = ?";
    $stmt = $db->query($sql, [$booking_id]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);


    if (!$list) {
        $list = [];
    }

    // unset($booking["booking_id"]);

    foreach ($list as &$step) {
        if ($step['received'] == 1) {
            $step['status'] = 'Completed Delivery';
        } else {
            $step['status'] = 'Wait for Completed Delivery';
        }
    
        $step['message'] = "Departed from {$step['destination_branch_name']} : {$step['status']}";
    }
    unset($step); // break the reference
    

    $data = ["status" => $list, "booking" => $booking];
    $response = new ApiResponse(200, "Success", $data);
    $response->toJson();
});

// Update tracking status //! DO NOT USE IT
$router->add("POST", "/track/update", function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

    $data = json_decode(file_get_contents("php://input"), true);
    $required_fields = ["status", "slip_no"];
    $handler->validateInput($data, $required_fields);

    $db = new Database();
    $sql = "UPDATE tracking SET status = ? WHERE slip_no = ?";
    $stmt = $db->query($sql, [$data["status"], $data["slip_no"]]);

    if ($stmt->rowCount() > 0) {
        $response = new ApiResponse(200, "Status updated successfully", null);
        $response->toJson();
    } else {
        $response = new ApiResponse(400, "Update failed: Slip not found or no change detected", null);
        $response->toJson();
    }
});
