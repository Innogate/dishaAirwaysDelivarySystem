<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
$router->add('POST', '/master/employees', function () {
    $pageID=7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");
    $payload = (object) [
        "fields" => ["employees.*"],
        "max" => 10,
        "current" => 0,
        "relation" => null,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE status = TRUE LIMIT ? OFFSET ?";
    $stmt = $db->query($sql, [$payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/employees/byId', function () {
    $pageID=7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object) [
        "fields" => ["employees.*"],
        "relation" => null,
        "employee_id" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE id = ?";
    $stmt = $db->query($sql, [$payload->employee_id]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if(!$list){
        (new ApiResponse(400, "Invalid Employee ID", "", 400))->toJson();
    }
    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/employees/byBranchId', function () {
    $pageID=7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object) [
        "fields" => ["employees.*"],
        "max" => 10,
        "current" => 0,
        "relation" => null,
        "branch_id" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE branch_id = ? AND status = TRUE LIMIT ? OFFSET ?";
    $stmt = $db->query($sql, [$payload->branch_id, $payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

$router->add('POST', '/master/employees/new', function () {
    $pageID=7;
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
    $pageID=7;
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

        $db->query("UPDATE employees SET status = FALSE WHERE id = ?", [$employee_id]);

        $db->commit();
        (new ApiResponse(200, "Employee deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

$router->add("POST", "/master/employees/update", function () {
    $pageID=7;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u"); // "d" for delete permission

    $payload = (object) [
        "updates" => [
            'talbe.name' => 'Error'
        ],
        "conditions" => [
            'talbe.id' => 0
        ]
    ];

    $data = json_decode(file_get_contents("php://input"), true);


    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicUpdate($payload->updates, $payload->conditions);

    // Debug: Print generated SQL query and parameters
    error_log("SQL Query: " . $sql["query"]);
    error_log("Parameters: " . json_encode($sql["params"]));

    try {
        $stmt = $db->query($sql["query"], $sql["params"]);

        if ($stmt->rowCount() > 0) {
            (new ApiResponse(200, "Update successful", $stmt->rowCount()))->toJson();
        } else {
            (new ApiResponse(500, "No rows updated"))->toJson();
        }
    } catch (Exception $e) {
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
})
?>
