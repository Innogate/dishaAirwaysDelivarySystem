<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';
global $router;
global $pageID;
$pageID = 1;

// GET ALL BOOKING
$router->add('POST', '/booking', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

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
    if ($isAdmin && $_info->branch_id == null) {
        $sql = "SELECT 
    b.*, 
    br.branch_name AS branch_name, 
    dbr.branch_name AS destination_branch_name
FROM bookings b
JOIN branches br ON b.branch_id = br.branch_id
JOIN branches dbr ON b.destination_branch_id = dbr.branch_id 
WHERE NOT b.status = '4' AND b.manifest_id IS NULL 
ORDER BY created_at DESC 
LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$payload->max, $payload->current]);
    } else {
        $sql = "SELECT 
    b.*, 
    br.branch_name AS booking_branch_name, 
    dbr.branch_name AS destination_branch_name
FROM bookings b
JOIN branches br ON b.branch_id = br.branch_id
JOIN branches dbr ON b.destination_branch_id = dbr.branch_id
WHERE b.branch_id = ?
  AND ((NOT b.status = '4')) AND ((b.manifest_id IS NULL) OR (b.status = '5' AND NOT b.branch_id = ?))
ORDER BY b.created_at DESC 
LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$_info->branch_id, $_info->branch_id, $payload->max, $payload->current]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$list) $list = [];
    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET ALL BOOKING BY BRANCH ID
$router->add('POST', '/booking/byDestinationBranch', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0,
        "destination_branch_id" => 0
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    if ($isAdmin && $_info->branch_id == null) {
        $sql = "SELECT 
    b.*, 
    br.branch_name AS branch_name, 
    dbr.branch_name AS destination_branch_name
FROM bookings b
JOIN branches br ON b.branch_id = br.branch_id
JOIN branches dbr ON b.destination_branch_id = dbr.branch_id 
WHERE b.destination_branch_id = ? 
ORDER BY created_at DESC 
LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$payload->destination_branch_id, $payload->max, $payload->current]);
    } else {
        $sql = "SELECT 
    b.*, 
    br.branch_name AS booking_branch_name, 
    dbr.branch_name AS destination_branch_name
FROM bookings b
JOIN branches br ON b.branch_id = br.branch_id
JOIN branches dbr ON b.destination_branch_id = dbr.branch_id
WHERE b.branch_id = ? AND b.destination_branch_id = ? 
ORDER BY b.created_at DESC 
LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$_info->branch_id, $payload->destination_branch_id, $payload->max, $payload->current]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$list) $list = [];
    (new ApiResponse(200, "Success", $list))->toJson();
});

// ADD NEW BOOKING
$router->add("POST", "/booking/new", function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");
    if ($isAdmin) {
        (new ApiResponse(200, "You are admin accout branch or branch employee account requred", $pageID))->toJson();
    }

    $data = json_decode(file_get_contents("php://input"), true);

    $required_fields = [
        "consignee_name", "consignee_mobile", "consignor_name", "consignor_mobile",
        "slip_no", "transport_mode", "paid_type", "cgst", "sgst", "igst",
        "total_value", "package_count", "package_weight", "package_value",
        "to_pay", "on_account",
    ];

    $handler->validateInput($data, $required_fields);
    $db = new Database();
    $db->beginTransaction();

    try {
        $sql = "SELECT branch_short_name FROM branches WHERE branch_id = ?;";
        $stmt = $db->query($sql, [$_info->branch_id]);
        $branch = $stmt->fetch(PDO::FETCH_ASSOC);
        $slip_no = $branch["branch_short_name"] . "-" . $data["slip_no"];

        $stmt = $db->query("SELECT * FROM bookings WHERE slip_no = ?", [$slip_no]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(400, "Receipt number already used", "Contact to main branch for token", 400))->toJson();
            return;
        }

        $sql = "INSERT INTO bookings (
            consignee_name, consignee_mobile, consignor_name, consignor_mobile, branch_id, 
            slip_no, booking_address, transport_mode, paid_type, cgst, sgst, igst, 
            total_value, package_count, package_weight, package_value, package_contents, 
            shipper_charges, destination_city_id, destination_branch_id, xp_branch_id, 
            created_by, on_account, to_pay, declared_value, other_charges, status
        ) VALUES (
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
        )";
        $db->query($sql, [
            $data["consignee_name"], $data["consignee_mobile"], $data["consignor_name"],
            $data["consignor_mobile"], $_info->branch_id, $slip_no, $data["booking_address"],
            $data["transport_mode"], $data["paid_type"], $data["cgst"], $data["sgst"], $data["igst"],
            $data["total_value"], $data["package_count"], $data["package_weight"], $data["package_value"],
            $data["package_contents"], $data["shipper_charges"], $data["destination_city_id"],
            $data["destination_branch_id"], $data["xp_branch_id"], $_info->user_id, $data["on_account"],
            $data["to_pay"], $data["declared_value"], $data["other_charges"], "0"
        ]);

        $db->commit();
        (new ApiResponse(200, "Receipt generated successfully", $slip_no, 200))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

// cancel booking
$router->add('POST', '/booking/cancel', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["booking_id"]);

    $db = new Database();
    try {
        $db->beginTransaction();
        $stmt = $db->query("UPDATE bookings SET status = '4' WHERE booking_id = ?", [$data["booking_id"]]);
        if ($stmt->rowCount() == 0) {
            $db->rollBack();
            (new ApiResponse(500, "Server error"))->toJson();
            return;
        }
        $db->commit();
        (new ApiResponse(200, "Receipt cancel successfully", $data["booking_id"], 200))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

// forward booking
$router->add('POST', '/booking/forward', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["booking_id"]);

    $db = new Database();
    try {
        $db->beginTransaction();
        $stmt = $db->query("UPDATE bookings SET status = 5 WHERE booking_id = ?", [$data["booking_id"]]);
        if ($stmt->rowCount() == 0) {
            $db->rollBack();
            (new ApiResponse(500, "Server error"))->toJson();
            return;
        }
        $db->commit();
        (new ApiResponse(200, "Receipt forward successfully", $data["booking_id"], 200))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});
?>
