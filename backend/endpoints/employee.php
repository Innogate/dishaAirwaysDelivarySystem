<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$pageID = 7; // Change page ID for Employee Master

$router->add('POST', '/master/employees', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    $require_fids=["from"];
    $handler->validateInput($data, $require_fids);
    $db = new Database();
    $stmt = $db->query("SELECT * FROM employees LIMIT 10 OFFSET ?", [$data["from"]]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/employees/byId', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    $require_fids = ["employees_id"];
    $handler->validateInput($data, $require_fids);

    $db = new Database();
    $stmt = $db->query("SELECT * FROM employees WHERE id = ?", [$data["employees_id"]]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/employees/byBranchId', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    $require_fids = ["branch_id", "from"];
    $handler->validateInput($data, $require_fids);

    $db = new Database();
    $stmt = $db->query("SELECT * FROM employees WHERE branch_id = ? LIMIT 10 OFFSET ?", [ $data["branch_id"], $data["from"]]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/employees/new', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    $requiredFields = ["user_id", "address", "adhara_no", "joining_date", "branch_id", "type"];
    foreach ($requiredFields as $field) {
        if (!isset($data[$field]) || empty(trim($data[$field]))) {
            (new ApiResponse(400, "All fields are required."))->toJson();
            return;
        }
    }

    $db = new Database();

    try {
        $db->beginTransaction();

        // Check if the provided branch_id exists
        $stmt = $db->query("SELECT id FROM branches WHERE id = ?", [$data["branch_id"]]);
        $brach_id =$stmt->fetch(PDO::FETCH_ASSOC);
        if (!$brach_id) {
            (new ApiResponse(404, "Branch not found.", ""))->toJson();
            return;
        }

        // Check if employee already exists with the same email or mobile
        $stmt = $db->query("SELECT id FROM employees WHERE user_id = ?", [$brach_id["id"]]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Employee with this email or mobile number already exists."))->toJson();
            return;
        }

        $stmt = $db->query(
            "INSERT INTO employees (user_id, address, aadhar_no, joining_date, branch_id, type, created_by) 
            VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id",
            [$data["user_id"], $data["address"], $data["adhara_no"], $data["joining_date"], $brach_id["id"], $data["type"], $_info->user_id]
        );
        $employee_id = $stmt->fetch(PDO::FETCH_ASSOC)["id"];
        $db->commit();
        (new ApiResponse(200, "Employee created successfully.", $employee_id))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

$router->add('POST', '/master/employees/delete', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data["employee_id"]) || !is_numeric($data["employee_id"])) {
        (new ApiResponse(400, "Invalid employee ID."))->toJson();
        return;
    }

    $employee_id = (int) $data["employee_id"];
    $db = new Database();

    try {
        $db->beginTransaction();

        // Check if employee exists
        $stmt = $db->query("SELECT id FROM employees WHERE id = ?", [$employee_id]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "Employee not found."))->toJson();
            return;
        }

        $db->query("DELETE FROM employees WHERE id = ?", [$employee_id]);

        $db->commit();
        (new ApiResponse(200, "Employee deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});
?>
