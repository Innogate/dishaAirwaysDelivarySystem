<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';
global $router;
global $pageID;
$pageID = 1;

$router->add('POST', '/booking', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page

    $allow_tables = ["bookings", "packages", "branches", "cities"];

    $payload = (object) [
        "max" => 10,
        "current" => 0
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }


    $db = new Database();
    if ($isAdmin) {
        $sqlQuery = "SELECT 
    bookings.*, 
    packages.*, 
    branches.id AS branch_id, 
    branches.name AS branch_name, 
    cities.*
FROM bookings
JOIN packages ON bookings.package_id = packages.id
JOIN branches ON bookings.destination_branch_id = branches.id
JOIN cities ON bookings.destination_city_id = cities.id
LIMIT ? OFFSET ?;
";
        $stmt = $db->query($sqlQuery, [$payload->max, $payload->current]);
    } else {
        $sqlQuery = "SELECT 
    bookings.*, 
    packages.*, 
    branches.id AS branch_id, 
    branches.name AS branch_name, 
    cities.*
FROM bookings
JOIN packages ON bookings.package_id = packages.id
JOIN branches ON bookings.destination_branch_id = branches.id
JOIN cities ON bookings.destination_city_id = cities.id
JOIN employees e1 ON bookings.created_by = e1.user_id
WHERE e1.branch_id = (
    SELECT e2.branch_id FROM employees e2 WHERE e2.user_id = ?
)
LIMIT ? OFFSET ?;";
        $stmt = $db->query($sqlQuery, [$_info->user_id, $payload->max, $payload->current]);
    }

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
        "consignee_id",
        "consignor_id",
        "transport_mode",
        "paid_type",
        "destination_city_id",
        "destination_branch_id",
        "count",
        "value",
        "contents",
        "charges",
        "shipper",
        "cgst",
        "sgst",
        "igst",
        "weight",
        "address"
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


        // GET TOKEN FROM credit_node table take last recode
        $sql = "SELECT * FROM credit_node WHERE branch_id = ? ORDER BY id DESC LIMIT 1;
";
        $stmt = $db->query($sql, [$branch["branch_id"]]);
        $token = $stmt->fetch(PDO::FETCH_ASSOC);
        // check toke unused garter then 0 or not 
        if (!$token) {
            (new ApiResponse(400, "Don't have any token", "Contact to main branch for token", 400))->toJson();(new ApiResponse(400, "Don't have any token", "Contact to main branch for token", 400))->toJson();
        }

        if ($token["unused"] <= 0) {
            (new ApiResponse(400, "Maximum token used", "Contact to main branch for token", 400))->toJson();
        }

        $slip_no = ($token["end_no"] - $token["unused"]) + 1;

        // update token unused
        $sql = "UPDATE credit_node SET unused = unused - 1 WHERE id = ?";
        $stmt = $db->query($sql, [$token["id"]]);


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
        if (!$package_id)
            throw new Exception("Package Creation Error");

        // Insert booking
        $stmt = $db->query("INSERT INTO bookings(
            branch_id, slip_no, consignee_id, consignor_id, transport_mode, package_id, 
            paid_type, cgst, sgst, igst, total_value, destination_city_id, destination_branch_id, address, created_by
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) RETURNING id", [
            $branch['branch_id'],
            $slip_no,
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
        if (!$receipt_no)
            throw new Exception("Receipt Creation Error");

        $db->commit(); // Commit transaction if successful
        (new ApiResponse(200, "Receipt generated successfully", $receipt_no, 200))->toJson();

    } catch (Exception $e) {
        $db->rollBack(); // Rollback transaction if error occurs
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});


?>