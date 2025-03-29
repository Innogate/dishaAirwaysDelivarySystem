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
        (new ApiResponse(404,'You not login brach account'))->toJson();
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
    $sql = $db->generateDynamicQuery("received_booking", $payload->fields)." WHERE status = TRUE AND branch_id = ? LIMIT ? OFFSET ?";
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
        (new ApiResponse(404,'You not login brach account'))->toJson();
    }

    $data = json_decode(file_get_contents("php://input"), true);

    $required_fields = [
        "slip_no"
    ];

    $handler->validateInput($data, $required_fields);
    $db = new Database();
    $db->beginTransaction();

    try {
        $status = (bool) true;
        // checking sleep_no valid or not 
        $sql = "SELECT booking_id, destination_branch_id  FROM bookings WHERE slip_no = ?";
        $stmt = $db->query($sql, [$data["slip_no"]]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$result) {
            throw new Exception("Invalid Slip No");
        }
        $booking_id = $result["booking_id"];
        // check destination branch is current branch or not
        if ($result["destination_branch_id"] == $_info->branch_id) {
            $status = (bool) false;
        }
        
        // validate this booking id for this branch
        $sql = "SELECT tracking_id FROM tracking WHERE booking_id = ? AND destination_branch_id = ?";
        $stmt = $db->query($sql, [$booking_id, $_info->branch_id]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$result) {
            (new ApiResponse(404,"Invalid Slip No"))->toJson();
        }
        $tracking_id = $result["tracking_id"];
        
        // INSET IN received_bookings
        $sql = "INSERT INTO received_booking (booking_id, branch_id, status) VALUES (?, ?, ?)";
        $stmt = $db->query($sql, [$booking_id, $_info->branch_id,  (int) $status]);
        if (!$stmt->rowCount()) {
            (new ApiResponse(404,"Something went wrong"))->toJson();
        }
        // UPDATE tracking  received true
        $sql = "UPDATE tracking SET received = TRUE WHERE tracking_id = ?";
        $stmt = $db->query($sql, [$tracking_id]);
        if (!$stmt->rowCount()) {
            (new ApiResponse(404,"Something went wrong"))->toJson();
        }
        $db->commit();
        (new ApiResponse(200, "Success", null))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(400, $e->getMessage()))->toJson();
    }
});
?>