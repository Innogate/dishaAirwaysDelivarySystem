<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// Get all employees
$router->add('POST', '/master/employees', function () {
    $pageID = 7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object)[
        "fields" => [],
        "max" => 10,
        "current" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object)$data;
    }

    $limit = intval($payload->max);
    $offset = intval($payload->current);

    $db = new Database();
    if ($isAdmin && $_info->branch_id == null) {
        $sql = "SELECT e.*, br.branch_name 
                FROM employees AS e 
                JOIN branches AS br ON br.branch_id = e.branch_id 
                LIMIT ? OFFSET ?";
        $stmt = $db->query($sql, [$limit, $offset]);
    } else {
        $sql = $db->generateDynamicQuery("employees", $payload->fields) . " WHERE branch_id = ? LIMIT ? OFFSET ?";
        $stmt = $db->query($sql, [$_info->branch_id, $limit, $offset]);
    }

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    (new ApiResponse(200, "Success", $list))->toJson();
});

// Get employee by ID
$router->add('POST', '/master/employees/byId', function () {
    $pageID = 7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object)[
        "fields" => [],
        "employee_id" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object)$data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery("employees", $payload->fields) . " WHERE employee_id = ?";
    $stmt = $db->query($sql, [$payload->employee_id]);
    $employee = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$employee) {
        (new ApiResponse(400, "Invalid Employee ID", "", 400))->toJson();
        return;
    }

    (new ApiResponse(200, "Success", $employee))->toJson();
});

// Create new employee
$router->add('POST', '/master/employees/new', function () {
    $pageID = 7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    $requiredFields = ["employee_name", "employee_mobile"];
    $handler->validateInput($data, $requiredFields);

    if ($_info->branch_id == null) {
        (new ApiResponse(400, "You are not a branch admin"))->toJson();
        return;
    }

    $db = new Database();

    try {
        $db->beginTransaction();

        // Check for duplicate mobile
        $stmt = $db->query("SELECT employee_id FROM employees WHERE employee_mobile = ?", [$data["employee_mobile"]]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Employee with this mobile already exists."))->toJson();
            return;
        }

        $db->query(
            "INSERT INTO employees (
                employee_name, 
                employee_mobile, 
                address, 
                aadhar_no, 
                joining_date, 
                branch_id, 
                created_by,
                designation
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
            [
                $data["employee_name"],
                $data["employee_mobile"],
                $data["address"] ?? null,
                $data["aadhar_no"] ?? null,
                $data["joining_date"] ?? null,
                $_info->branch_id,
                $_info->user_id,
                $data["designation"] ?? null
            ]
        );

        $employee_id = $db->lastInsertId();

        $db->commit();
        (new ApiResponse(200, "Employee created successfully.", $employee_id))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// Delete employee (soft delete)
$router->add('POST', '/master/employees/delete', function () {
    $pageID = 7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);
    if (!isset($data["employee_id"]) || !is_numeric($data["employee_id"])) {
        (new ApiResponse(400, "Invalid employee ID."))->toJson();
        return;
    }

    $employee_id = (int)$data["employee_id"];
    $db = new Database();

    try {
        $db->beginTransaction();

        // Check if employee exists
        $stmt = $db->query("SELECT employee_id FROM employees WHERE employee_id = ?", [$employee_id]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "Employee not found."))->toJson();
            return;
        }

        $db->query("UPDATE employees SET status = 0 WHERE employee_id = ?", [$employee_id]);

        $db->commit();
        (new ApiResponse(200, "Employee deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// Update employee
$router->add("POST", "/master/employees/update", function () {
    $pageID = 7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u");

    $payload = (object)[
        "updates" => [],
        "conditions" => "employee_id=0"
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object)$data;
    }

    $db = new Database();
    $sql = $db->generateDynamicUpdate("employees", $payload->updates, $payload->conditions);

    try {
        $stmt = $db->query($sql[0], $sql[1]);
        if ($stmt->rowCount() > 0) {
            (new ApiResponse(200, "Update successful", $stmt->rowCount()))->toJson();
        } else {
            (new ApiResponse(500, "No rows updated"))->toJson();
        }
    } catch (Exception $e) {
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});
?>
