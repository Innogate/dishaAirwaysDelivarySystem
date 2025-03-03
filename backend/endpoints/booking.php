<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';
global $router;
global $pageID;
$pageID = 1;

$router->add('POST', '/booking', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r"); // Check user permission for this page

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["from"]);

    $db = new Database();
    $stmt = $db->query("SELECT * FROM bookings LIMIT 100 OFFSET ?", [$data["from"]]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC); // Fix fetch issue

    if (!$list) {
        $list = [];
    }

    (new ApiResponse(200, "Success", $list))->toJson();
});

//  ADD NEW BOOKING
$router->add("POST", "/booking/new", function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

    $data = json_decode(file_get_contents("php://input"), true);

    $require_data = ["slip_no", "consignee_name", "consignee_mobile", "transport_mode", "paid_type", "destination_city_id", "destination_branch_id", "count", "value", "contents", "charges", "shipper", "cgst", "sgst", "igst"];
    $handler->validateInput($data, $require_data);

    $db = new Database();
    $stmt = $db->query("SELECT id FROM employees WHERE user_id = ?", [$data["user_id"]]);
    $branch = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$branch) {
        (new ApiResponse(500, "Internal Server Error: Branch not found", "", 500))->toJson();
        exit;
    }

    $db->query("INSERT INTO packages (count, value, contents, charges, shipper, cgst, sgst, igst, created_by) VALUES (?,?,?,?,?,?,?,?,?)", [
        $data["count"],
        $data["value"],
        $data["contents"],
        $data["charges"],
        $data["shipper"],
        $data["cgst"],
        $data["sgst"],
        $data["igst"],
        $_info->user_id
    ]);

    $package_id = $db->lastInsertId(); // Fix RETURNING id issue for MySQL
    if (!$package_id) {
        (new ApiResponse(404, "Package Creation Error", "", 404))->toJson();
        exit;
    }

    $db->query("INSERT INTO bookings(branch_id, slip_no, consignee_name, consignee_mobile, transport_mode, package_id, paid_type, destination_city_id, destination_branch_id, created_by) VALUES (?,?,?,?,?,?,?,?,?,?)", [
        $branch['branch_id'],
        $data["slip_no"],
        $data["consignee_name"],
        $data["consignee_mobile"],
        $data["transport_mode"],
        $package_id,
        $data["paid_type"],
        $data["destination_city_id"],
        $data["destination_branch_id"],
        $_info->user_id
    ]);

    $receipt_no = $db->lastInsertId(); // Fix RETURNING id issue for MySQL
    $db->commit();

    (new ApiResponse(200, "Receipt generated successfully", $receipt_no, 200))->toJson();
});
?>
