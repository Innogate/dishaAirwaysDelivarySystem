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
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

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
        $sql = $db->generateDynamicQuery("bookings", $payload->fields) . "  ORDER BY created_at DESC LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$payload->max, $payload->current]);
    } else {
        $sql = $db->generateDynamicQuery("bookings", $payload->fields) . " WHERE branch_id = ?  ORDER BY created_at DESC LIMIT ? OFFSET ?;";
        // $sql = $db->modifySelectQueryWithForeignKeys($sql);
        $stmt = $db->query($sql, [$_info->branch_id, $payload->max, $payload->current]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (!$list) {
        $list = [];
    }

    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET ALL BOOKING BY city_id
$router->add('POST', '/booking/manifest', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0,
        "destination_city_id"=> 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }


    $db = new Database();
    if ($isAdmin && $_info->branch_id == null) {
        $sql = $db->generateDynamicQuery("bookings", $payload->fields) . " WHERE destination_branch_id = ? AND manifest_id = null  ORDER BY created_at DESC LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$payload->destination_branch_id,$payload->max, $payload->current]);
    } else {
        $sql = $db->generateDynamicQuery("bookings", $payload->fields) . " WHERE branch_id = ? AND destination_branch_id = ? AND manifest_id = null ORDER BY created_at DESC LIMIT ? OFFSET ?;";
        // $sql = $db->modifySelectQueryWithForeignKeys($sql);
        $stmt = $db->query($sql, [$_info->branch_id, $payload->destination_branch_id, $payload->max, $payload->current]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (!$list) {
        $list = [];
    }

    (new ApiResponse(200, "Success", $list))->toJson();
});


// received
$router->add('POST', '/booking/received', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

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
        $sql = $db->generateDynamicQuery("bookings", $payload->fields) . "  ORDER BY created_at DESC LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$payload->max, $payload->current]);
    } else {
        $sql = $db->generateDynamicQuery("bookings", $payload->fields) . " WHERE destination_branch_id = ? ORDER BY created_at DESC LIMIT ? OFFSET ?;";
        $stmt = $db->query($sql, [$_info->branch_id, $payload->max, $payload->current]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (!$list) {
        $list = [];
    }

    (new ApiResponse(200, "Success", $list))->toJson();
});

//  ADD NEW BOOKING
$router->add("POST", "/booking/new", function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission

    $data = json_decode(file_get_contents("php://input"), true);

    $required_fields = [
        "consignee_name",
        "consignee_mobile",
        "consignor_name",
        "consignor_mobile",
        "slip_no",
        "transport_mode",
        "paid_type",
        "cgst",
        "sgst",
        "igst",
        "total_value",
        "package_count",
        "package_weight",
        "package_value",
        "to_pay",
        "on_account",
    ];

    $handler->validateInput($data, $required_fields);
    $db = new Database();
    $db->beginTransaction(); // Start transaction

    try {

        // GET TOKEN FROM credit_node table take last recode
        $sql = "SELECT * FROM credit_node WHERE branch_id = ? ORDER BY credit_node_id DESC LIMIT 1;
";
        $stmt = $db->query($sql, [$_info->branch_id]);
        $token = $stmt->fetch(PDO::FETCH_ASSOC);

        // check toke unused garter then 0 or not 
        if (!$token) {
            (new ApiResponse(400, "Don't have any token", "Contact to main branch for token", 400))->toJson();
        }

        // check sleep no in range
        $slip_no = (int)$data["slip_no"];
        if ($slip_no < $token["start_no"] || $slip_no > $token["end_no"]) {
            (new ApiResponse(400, "Slip number out of range", "Contact to main branch for token", 400))->toJson();
            return;
        }

        // check slip no used or not
        $stmt = $db->query("SELECT * FROM bookings WHERE slip_no = ?", [$slip_no]);
        $booking = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($booking) {
            (new ApiResponse(400, "Receipt number already used", "Contact to main branch for token", 400))->toJson();
            return;
        }

        // INSET IN booking table
        $sql = "INSERT INTO bookings (
            consignee_name, consignee_mobile, consignor_name, consignor_mobile, branch_id, 
            slip_no, booking_address, transport_mode, paid_type, cgst, sgst, igst, 
            total_value, package_count, package_weight, package_value, package_contents, 
            shipper_charges, destination_city_id, destination_branch_id, xp_branch_id, 
            created_by, on_account, to_pay
        ) VALUES (
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
        )";
        
        $stmt = $db->query($sql, [
            $data["consignee_name"],
            $data["consignee_mobile"],
            $data["consignor_name"],
            $data["consignor_mobile"],
            $_info->branch_id,
            $slip_no,
            $data["booking_address"],
            $data["transport_mode"],
            $data["paid_type"],
            $data["cgst"],
            $data["sgst"],
            $data["igst"],
            $data["total_value"],
            $data["package_count"],
            $data["package_weight"],
            $data["package_value"],
            $data["package_contents"],
            $data["shipper_charges"],
            $data["destination_city_id"],
            $data["destination_branch_id"],
            $data["xp_branch_id"],
            $_info->user_id,
            $data["on_account"],
            $data["to_pay"],
        ]);

        // INSET IN tracking table
        $sql = "INSERT INTO tracking (slip_no, tracking_status, branch_id) VALUES (?, ?, ?)";
        $stmt = $db->query($sql, [$slip_no, '0', $_info->branch_id]);
        $db->commit();
        (new ApiResponse(200, "Receipt generated successfully", $slip_no, 200))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});
