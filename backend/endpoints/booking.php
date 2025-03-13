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

    $payload = (object) [
        "fields" => ["bookings.*", "packages.*", "branches.*", "cities.*"],
        "max" => 10,
        "current" => 0,
        "relation" => "bookings.package_id=packages.id,bookings.destination_branch_id=branches.id,bookings.destination_city_id=cities.id",
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data; 
    }


    $db = new Database();
    $sqlQuery = $db->generateDynamicQuery($payload->fields, $payload->relation). " LIMIT ? OFFSET ?";

    $stmt = $db->query ($sqlQuery, [$payload->max, $payload->current]);
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
    $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission

    $data = json_decode(file_get_contents("php://input"), true);

    $required_fields = [
        "slip_no", "consignee_id", "consignor_id", "transport_mode",
        "paid_type", "destination_city_id", "destination_branch_id", 
        "count", "value", "contents", "charges", "shipper", 
        "cgst", "sgst", "igst", "weight", "address"
    ];
    $handler->validateInput($data, $required_fields);

    $db = new Database();
    $db->beginTransaction(); // Start transaction

    try {
        // Get employee branch ID
        $stmt = $db->query("SELECT branch_id FROM employees WHERE user_id = ?", [$_info->user_id]);
        $branch = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$branch) {
            throw new Exception("It is not an employee account.");
        }

        // Validate consignee existence
        $stmt = $db->query("SELECT id FROM consignee WHERE id = ?", [$data["consignee_id"]]);
        $consignee = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$consignee) {
            throw new Exception("Consignee does not exist. Please provide a valid consignee.");
        }
        $consignee_id = $consignee['id'];

        // Validate consignor existence
        $stmt = $db->query("SELECT id FROM consignor WHERE id = ?", [$data["consignor_id"]]);
        $consignor = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$consignor) {
            throw new Exception("Consignor does not exist. Please provide a valid consignor.");
        }
        $consignor_id = $consignor['id'];

        // Insert package
        $stmt = $db->query("INSERT INTO packages (count, weight, value, contents, charges, shipper, created_by) 
                            VALUES (?,?,?,?,?,?,?) RETURNING id", [
            $data["count"],
            $data["weight"],
            $data["value"],
            $data["contents"],
            $data["charges"],
            $data["shipper"],
            $_info->user_id
        ]);
        $package_id = $stmt->fetchColumn();
        if (!$package_id) throw new Exception("Package Creation Error");

        // Insert booking
        $stmt = $db->query("INSERT INTO bookings(
            branch_id, slip_no, consignee_id, consignor_id, transport_mode, package_id, 
            paid_type, cgst, sgst, igst, total_value, destination_city_id, destination_branch_id, address, created_by
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) RETURNING id", [
            $branch['branch_id'],
            $data["slip_no"],
            $consignee_id,
            $consignor_id,
            $data["transport_mode"],
            $package_id,
            $data["paid_type"],
            $data["cgst"],
            $data["sgst"],
            $data["igst"],
            $data["value"],
            $data["destination_city_id"],
            $data["destination_branch_id"],
            $data["address"],
            $_info->user_id
        ]);

        $receipt_no = $stmt->fetchColumn();
        if (!$receipt_no) throw new Exception("Receipt Creation Error");

        $db->commit(); // Commit transaction if successful
        (new ApiResponse(200, "Receipt generated successfully", $receipt_no, 200))->toJson();

    } catch (Exception $e) {
        $db->rollBack(); // Rollback transaction if error occurs
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});


?>