<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';
global $router;
global $pageID;
$pageID = 1;

$router->add('POST', '/booking', function () {
    $pageID=1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["from"]);

    $db = new Database();
    $stmt = $db->query("SELECT 
    b.id AS booking_id,
    b.slip_no,
    b.consignee_name,
    b.consignee_mobile,
    b.consignor_name,
    b.consignor_mobile,
    b.transport_mode,
    b.paid_type,
    b.destination_city_id,
    c.name AS destination_city_name,
    b.destination_branch_id,
    br.name AS destination_branch_name,
    p.id AS package_id,
    p.container_id,
    p.count,
    p.weight,
    p.value,
    p.contents,
    p.charges,
    p.cgst,
    p.sgst,
    p.igst,
    b.created_at,
    b.created_by,
    p.created_at AS package_created_at,
    p.created_by AS package_created_by
FROM 
    bookings b
INNER JOIN 
    packages p ON b.package_id = p.id
INNER JOIN 
    branches br ON b.destination_branch_id = br.id
INNER JOIN 
    cities c ON b.destination_city_id = c.id
WHERE 
    b.status = TRUE 
    AND p.status = TRUE
LIMIT 100 OFFSET ?;", [$data["from"]]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC); // Fix fetch issue

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
    $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

    $data = json_decode(file_get_contents("php://input"), true);

    $require_data = ["slip_no", "consignee_name", "consignee_mobile", "consignor_name", "consignor_mobile", "transport_mode", "paid_type", "destination_city_id", "destination_branch_id", "count", "value", "contents", "charges", "shipper", "cgst", "sgst", "igst", "weight"];
    $handler->validateInput($data, $require_data);

    $db = new Database();
    $db->beginTransaction(); // Start transaction

    try {
        $stmt = $db->query("SELECT id FROM employees WHERE user_id = ?", [$_info->user_id]);
        $branch = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$branch) {
            throw new Exception("It is not a employee account.");
        }

        $smtp = $db->query("INSERT INTO packages (count, weight, value, contents, charges, shipper, cgst, sgst, igst, created_by) VALUES (?,?,?,?,?,?,?,?,?,?) RETURNING id", [
            $data["count"],
            $data["weight"],
            $data["value"],
            $data["contents"],
            $data["charges"],
            $data["shipper"],
            $data["cgst"],
            $data["sgst"],
            $data["igst"],
            $_info->user_id
        ]);

        $package_id = $smtp->fetchColumn();
        if (!$package_id) {
            throw new Exception("Package Creation Error");
        }

        $stmt = $db->query("INSERT INTO bookings(
        branch_id, slip_no, consignee_name, consignee_mobile, consignor_name, consignor_mobile, transport_mode, package_id, paid_type, destination_city_id, destination_branch_id, created_by
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?) RETURNING id", [
            $branch['id'],
            $data["slip_no"],
            $data["consignee_name"],
            $data["consignee_mobile"],
            $data["consignor_name"],
            $data["consignor_mobile"],
            $data["transport_mode"],
            $package_id,
            $data["paid_type"],
            $data["destination_city_id"],
            $data["destination_branch_id"],
            $_info->user_id
        ]);

        $receipt_no = $stmt->fetchColumn();
        if (!$receipt_no) {
            throw new Exception("Receipt Creation Error");
        }

        $db->commit(); // Commit transaction if everything is successful
        (new ApiResponse(200, "Receipt generated successfully", $receipt_no, 200))->toJson();

    } catch (Exception $e) {
        $db->rollBack(); // Rollback transaction if any error occurs
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

?>