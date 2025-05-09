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
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;
    $sql = $db->generateDynamicQuery("branches", $payload->fields) . " JOIN representatives ON representatives.branch_id = branches.branch_id WHERE branches.status = TRUE LIMIT $limit OFFSET $offset";
    $stmt = $db->query($sql);

    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    (new ApiResponse(200, "Success", $list))->toJson();
});

// GET ALL BRANCH BY ID
$router->add('POST', '/master/branches/byId', function () {
    $pageID = 6;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();

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
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;
    $db = new Database();
    $sql = $db->generateDynamicQuery("branches", $payload->fields) . " WHERE city_id = ? AND status = TRUE LIMIT $limit OFFSET $offset";
    $stmt = $db->query($sql, [$payload->city_id]);
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
        "representative_id",
        "manifest_sires"
    ]);

    $db = new Database();

    try {
        $db->beginTransaction();
        $lowerBranchName = strtolower($data["branch_name"]);
        $stmt = $db->query("SELECT branch_id FROM branches WHERE branch_name = ?", [$lowerBranchName]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(400, "Branch name already exists."))->toJson();
            return;
        }

        $lowerShortName = strtolower($data["branch_short_name"]);
        $stmt = $db->query("SELECT branch_id FROM branches WHERE branch_short_name = ?", [$lowerShortName]);
        if ($stmt->fetch(PDO::FETCH_ASSOC)) {
            (new ApiResponse(400, "Branch short name already exists."))->toJson();
            return;
        }

        $data["cgst"] = $data["cgst"] ?? 0;
        $data["sgst"] = $data["sgst"] ?? 0;
        $data["igst"] = $data["igst"] ?? 0;

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
            manifest_sires,
            created_by) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [
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
            $data["manifest_sires"],
            $_info->user_id
        ]);

        $branch_id = $db->pdo->lastInsertId();

        if (!$branch_id){
            $db->rollBack();
            (new ApiResponse(400,"Failed to create branch"))->toJson();
            return;    
        }

        $stmt = $db->query("INSERT INTO representatives (branch_id, user_id, created_by) VALUES (?,?,?)", [
            $branch_id,
            $data["representative_id"],
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

// UPDATE BRANCH
$router->add('POST', '/master/branches/update', function () {
    $pageID = 6;

    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "u");

    $data = json_decode(file_get_contents("php://input"), true);

    $payload = (object) [
        "conditions" => 'branch_id=0',
        "updates" => []
    ];

    if (!empty($data)) {
        $payload = (object) $data;
    } else {
        (new ApiResponse(400, "Invalid payload", $data))->toJson();
        return;
    }

    $representative_id = null;
    if (isset($payload->updates["representative_id"])) {
        $representative_id = $payload->updates["representative_id"];
        unset($payload->updates["representative_id"]);
    }

    $db = new Database();
    $db->pdo->beginTransaction();
    try {
        $sql = $db->generateDynamicUpdate("branches", $payload->updates, $payload->conditions);
        $stmt = $db->query($sql[0], $sql[1]);

        if ($representative_id !== null && isset($payload->updates["branch_id"])) {
            $sql = "UPDATE representatives SET user_id = ? WHERE branch_id = ?";
            $db->query($sql, [$representative_id, $payload->updates["branch_id"]]);
        }

        $db->pdo->commit();
        (new ApiResponse(200, "Branch updated successfully", null))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Update failed", $e->getMessage()))->toJson();
    }
});
