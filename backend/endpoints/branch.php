<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ . '/../core/Handler.php';

    global $router;
    global $pageID;

    $pageID = 6; // Change page ID for branch master

    // GET ALL BRANCH
    $router->add('POST', '/master/branches', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");

        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["from"]);
        $db = new Database();
        $stmt = $db->query("SELECT id, name, alias_name, address, city_id, state_id, pin_code, contact_no, email, company_id, gst_no, cin_no, udyam_no, logo FROM branches LIMIT 10 OFFSET ?", [$data["from"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

        (new ApiResponse(200, "Success", $list))->toJson();
    });

    // GET ALL BRANCH BY ID
    $router->add('POST', '/master/branches/byId', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");

        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["branch_id"]);
        $db = new Database();
        $stmt = $db->query("SELECT id, name, alias_name, address, city_id, state_id, pin_code, contact_no, email, company_id, gst_no, cin_no, udyam_no, logo FROM branches WHERE branch_id = ?", [$data["branch_id"]]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC);
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

        $handler->validateInput($data, ["company_id", "name", "address", "alias_name", "city_id", "state_id", "pin_code", "contact_no", "email", "gst_no", "cin_no", "udyam_no", "logo"]);

        $db = new Database();

        try {
            $db->beginTransaction();

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
                "INSERT INTO branches (company_id, name,alias_name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_by) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id",
                [$data["company_id"], $data["name"], $data["alias_name"], $data["address"], $data["city_id"], $data["state_id"], $data["pin_code"], 
                $data["contact_no"], $data["email"], $data["gst_no"], $data["cin_no"], $data["udyam_no"], $data["logo"], $_info->user_id]
            );

            $branch_id = $stmt->fetchColumn();

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

            $db->query("DELETE FROM branches WHERE id = ?", [$branch_id]);

            $db->commit();
            (new ApiResponse(200, "Branch deleted successfully."))->toJson();
        } catch (Exception $e) {
            $db->rollBack();
            (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
        }
    });
?>
