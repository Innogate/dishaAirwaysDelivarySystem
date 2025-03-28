<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
// ** GET ALL BRANCH
$router->add('POST', '/master/branches', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0,
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }


    $db = new Database();
    $sql = $db->generateDynamicQuery("branches", $payload->fields) . " WHERE status = TRUE LIMIT ? OFFSET ?";
    $stmt = $db->query($sql, [$payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET ALL BRANCH BY ID
$router->add('POST', '/master/branches/byId', function () {
    $pageID = 6;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    // $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0,
        "branch_id" => 0
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery("branches", $payload->fields) . " WHERE branch_id = ?";
    $stmt = $db->query($sql, [$payload->branch_id]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$list) {
        (new ApiResponse(400, "Invalid BRANCH ID", "", 400))->toJson();
    }

    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET BRACH BY CITY ID
$router->add('POST', '/master/branches/byCityId', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");
    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0,
        "city_id" => 0,
    ];
    $data = json_decode(file_get_contents("php://input"), true);

    $db = new Database();
    $sql = $db->generateDynamicQuery("branches", $payload->fields) . " WHERE city_id = ? AND status = TRUE LIMIT ? OFFSET ?";
    $stmt = $db->query($sql, [$payload->city_id, $payload->max, $payload->current]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$list) {
        (new ApiResponse(400, "Invalid BRANCH ID", "", 400))->toJson();
    }

    (new ApiResponse(200, "Success", $list))->toJson();
});

// ADD NEW BRANCH
$router->add('POST', '/master/branches/new', function () {
    global $pageID;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    $handler->validateInput($data, [
        "branch_name",
        "branch_short_name",
        "alias_name",
        "city_id",
        "state_id",
        "city_id",
        "contact_no",
        "representative_user_id"
    ]);

    $db = new Database();

    try {
        $db->beginTransaction();
        // check brach name already exists
        // convert to lower case
        $lowerBranchName = strtolower($data["branch_name"]);
        $stmt = $db->query("SELECT branch_id FROM branches WHERE branch_name = ?", [$lowerBranchName]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(400, "Branch name already exists."))->toJson();
            return;
        }

        // check short name already exists
        $lowerShortName = strtolower($data["branch_short_name"]);
        $stmt = $db->query("SELECT branch_id FROM branches WHERE branch_short_name = ?", [$lowerShortName]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(400, "Branch short name already exists."))->toJson();
            return;
        }
        
        $data["cgst"] = $data["cgst"] ?? 0;
        $data["sgst"] = $data["sgst"] ?? 0;
        $data["igst"] = $data["igst"] ?? 0;
        
        // INSERT BRANCH
        $stmt = $db->query("INSERT INTO branches (
        branch_name, 
        branch_short_name, 
        alias_name, 
        address, 
        city_id, 
        state_id, 
        pin_code, 
        contact_no, 
        email, 
        gst_no, 
        cin_no, 
        udyam_no, 
        cgst, 
        sgst, 
        igst, 
        logo, 
        created_by) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) RETURNING branch_id", [
            $data["branch_name"],
            $data["branch_short_name"],
            $data["alias_name"],
            $data["address"],
            $data["city_id"],
            $data["state_id"],
            $data["pin_code"],
            $data["contact_no"],
            $data["email"],
            $data["gst_no"],
            $data["cin_no"],
            $data["udyam_no"],
            $data["cgst"],
            $data["sgst"],
            $data["igst"],
            $data["logo"],
            $_info->user_id
            
        ]);

        $branch_id = $stmt->fetchColumn();

        if (!$branch_id){
            $db->rollBack();
            (new ApiResponse(400,"Failed to create branch"))->toJson();
            return;    
        }
        
        // INSERT REPRESENTATIVE
        $stmt = $db->query("INSERT INTO representatives (branch_id, user_id, created_by) VALUES (?,?,?)", [
            $branch_id,
            $data["representative_user_id"],
            $_info->user_id
        ]);

        $db->commit();
        (new ApiResponse(200, "Branch created successfully.", $branch_id))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// DELETE BRANCH BY ID
$router->add('POST', '/master/branches/delete', function () {
    $pageID=6;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["branch_id"]);

    $branch_id = (int) $data["branch_id"];
    $db = new Database();

    try {
        $db->beginTransaction();

        // Check if branch exists
        $stmt = $db->query("SELECT branch_id FROM branches WHERE branch_id = ?", [$branch_id]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "Branch not found."))->toJson();
            return;
        }

        $db->query("UPDATE branches SET status = FALSE WHERE branch_id = ?", [$branch_id]);

        $db->commit();
        (new ApiResponse(200, "Branch deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

$router->add('POST', '/master/branches/update', function () {
    // Define the page ID for permissions check
    $pageID = 6;
    
    // Create instances of JwtHandler and Handler for authentication and permission validation
    $jwt = new JwtHandler();
    $handler = new Handler();

    // Validate JWT and permissions
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u"); // "u" for update permission

    // Decode the JSON payload from the incoming request
    $data = json_decode(file_get_contents("php://input"), true);

    // Define a default payload structure
    $payload = (object) [
        "conditions" => 'branch_id=0',
        "updates" => []
    ];

    // If the payload data is not empty, overwrite the default payload with the incoming data
    if (!empty($data)) {
        $payload = (object) $data;
    } else {
        // If payload is empty, return an error response
        (new ApiResponse(400, "Invalid payload", $data))->toJson();
        return;
    }

    // Initialize Database connection
    $db = new Database();
    $db->pdo->beginTransaction();
    try {

        // Update the branch in the database
        $sql = $db->generateDynamicUpdate("branches", $payload->updates, $payload->conditions);
        $stmt = $db->query($sql[0], $sql[1]);

        // Commit the transaction and return a success response
        $db->pdo->commit();
        (new ApiResponse(200, "Branch updated successfully", $stmt->fetchColumn()))->toJson();
    } catch (Exception $e) {
        // Handle any errors and respond with the error message
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});



