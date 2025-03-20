<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$pageID = 6; // Change page ID for branch master

// GET ALL BRANCH
$router->add('POST', '/master/branches', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");
    $payload = (object) [
        "fields" => ["branches.*"],
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

// GET ALL BRANCH BY ID
$router->add('POST', '/master/branches/byId', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    // $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object) [
        "fields" => ["branches.*"],
        "max" => 10,
        "current" => 0,
        "relation" => null,
    ];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE id = ?";
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
        "fields" => ["branches.*"],
        "max" => 10,
        "current" => 0,
        "relation" => null,
        "city_id" => 0,
    ];
    $data = json_decode(file_get_contents("php://input"), true);

    $db = new Database();
    $sql = $db->generateDynamicQuery($payload->fields, $payload->relation) . " WHERE city_id = ? AND status = TRUE LIMIT ? OFFSET ?";
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

    $handler->validateInput($data, ["company_id", "name", "city_id", "state_id",  "contact_no"]);

    $db = new Database();

    try {
        $db->beginTransaction();

        // Check if mobile number already exists
        $stmt = $db->query("SELECT id FROM users WHERE mobile = ?", [$data["contact_no"]]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Mobile number already exists."))->toJson();
            return;
        }

        // Insert user
        $stmt = $db->query(
            "INSERT INTO users (mobile, password, created_by) VALUES (?, ?, ?) RETURNING id",
            [$data["contact_no"], $data["password"] ?? "defualtPassword", $_info->user_id]
        );

        $user_id = $stmt->fetchColumn();


        // Check if the provided company_id exists
        $stmt = $db->query("SELECT id FROM companies WHERE id = ?", [$data["company_id"]]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "Company not found."))->toJson();
            return;
        }

        // Check if branch already exists for the same company with the same name
        $stmt = $db->query("SELECT id FROM branches WHERE company_id = ? AND name = ?", [$data["company_id"], $data["name"]]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(409, "Branch with this name already exists for the company."))->toJson();
            return;
        }

        $stmt = $db->query(
            "INSERT INTO branches 
            (name, alias_name, address, city_id, user_id, state_id, company_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, cgst, sgst, igst, logo, created_by) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id",
            [
                $data["name"],
                $data["alias_name"],
                $data["address"],
                $data["city_id"],
                $user_id,
                $data["state_id"],
                $data["company_id"],
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
                $_info->user_id // Ensure this exists
            ]
        );


        $branch_id = $stmt->fetchColumn();


        $stmt = $db->query("INSERT INTO permissions (page_id, permission_code, user_id, created_by) VALUES (?, ?, ?, ?)", ["4", "1111", $user_id, $_info->user_id]);
        $stmt = $db->query("INSERT INTO permissions (page_id, permission_code, user_id, created_by) VALUES (?, ?, ?, ?)", ["7", "1111", $user_id, $_info->user_id]);
        $stmt = $db->query("INSERT INTO permissions (page_id, permission_code, user_id, created_by) VALUES (?, ?, ?, ?)", ["8", "1111", $user_id, $_info->user_id]);


        $db->commit();
        (new ApiResponse(200, "Branch created successfully.", $branch_id))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// DELETE BRANCH BY ID
$router->add('POST', '/master/branches/delete', function () {
    global $pageID;
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
        $stmt = $db->query("SELECT id FROM branches WHERE id = ?", [$branch_id]);
        if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(404, "Branch not found."))->toJson();
            return;
        }

        $db->query("UPDATE branches SET status = FALSE WHERE id = ?", [$branch_id]);

        $db->commit();
        (new ApiResponse(200, "Branch deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

$router->add('POST', '/master/branches/update', function () {
    // Define the page ID for permissions check
    $pageID = 2;
    
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
        "conditions" => [
            'branches.id' => 0,
        ],
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

    // Prepare the update query and parameters for the branches table
    $updateQuery = "UPDATE branches SET ";
    $updateParams = [];
    $setFields = [];

    // Dynamically build the SET clause for the update query
    foreach ($payload->updates as $column => $value) {
        $setFields[] = "$column = ?";
        $updateParams[] = $value;
    }

    // Ensure there is at least one field to update
    if (empty($setFields)) {
        (new ApiResponse(400, "No fields to update"))->toJson();
        return;
    }

    // Add the WHERE clause to the update query
    $updateQuery .= implode(", ", $setFields) . " WHERE id = ?"; 
    $updateParams[] = $payload->conditions['id'];

    // Debug: Print generated SQL query and parameters for troubleshooting
    error_log("SQL Query: " . $updateQuery);
    error_log("Parameters: " . json_encode($updateParams));

    try {
        // Execute the update query for the branches table
        $stmt = $db->query($updateQuery, $updateParams);

        // Check if any rows were updated
        if ($stmt->rowCount() > 0) {
            // Retrieve the associated user_id from the branches table
            $stmt = $db->query("SELECT user_id, contact_no FROM branches WHERE id = ?", [$payload->conditions['id']]);
            $branchData = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($branchData) {
                // Check if the contact_no in the branch has been updated
                if (isset($payload->updates['contact_no'])) {
                    // Update the user's mobile number in the users table if the branch mobile has been updated
                    $stmt = $db->query("UPDATE users SET mobile = ? WHERE id = ?", [
                        $payload->updates['contact_no'], 
                        $branchData["user_id"]
                    ]);
                }
            }

            // Respond with a success message
            (new ApiResponse(200, "Update successful", null))->toJson();
        } else {
            // Respond if no rows were updated
            (new ApiResponse(500, "No rows updated"))->toJson();
        }
    } catch (Exception $e) {
        // Handle any errors and respond with the error message
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});



