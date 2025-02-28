<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

    $pageID = 5;

    $router->add('POST', '/master/companies', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");
        $data = json_decode(file_get_contents("php://input"), true);
        
        $db = new Database();
        $stmt = $db->query("SELECT * FROM companies LIMIT 10 OFFSET ?", [$data["from"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$list) {
            $list = [];
        }
        
        (new ApiResponse(200, "Success", $list))->toJson();
    });

    $router->add('POST', '/master/companies/new', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "w");

        $data = json_decode(file_get_contents("php://input"), true);

        $requiredFields = ["name", "address", "city_id", "state_id", "pin_code", "contact_no", "email", "gst_no", "cin_no", "udyam_no", "logo"];
        foreach ($requiredFields as $field) {
            if (!isset($data[$field]) || empty(trim($data[$field]))) {
                (new ApiResponse(400, "All fields are required."))->toJson();
                return;
            }
        }

        $db = new Database();
        
        try {
            $db->beginTransaction();

            // Check if the mobile number already exists
            $stmt = $db->query("SELECT id FROM users WHERE mobile = ?", [$data["contact_no"]]);
            $existingUser = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($existingUser) {
                (new ApiResponse(400, "User with this mobile number already exists."))->toJson();
                return;
            }
            
            $stmt = $db->query("INSERT INTO users (mobile, password, created_by) VALUES (?, ?, ?) RETURNING id", 
                [$data["contact_no"], "defaultPass123", $_info->user_id]
            );
            $user_id = $stmt->fetchColumn();

            if (!$user_id) {
                throw new Exception("User account creation failed.");
            }
            
            $stmt = $db->query("INSERT INTO companies (name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_by) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id", 
                [$data["name"], $data["address"], $data["city_id"], $data["state_id"], $data["pin_code"],
                $data["contact_no"], $data["email"], $data["gst_no"], $data["cin_no"], $data["udyam_no"],
                $data["logo"], $_info->user_id]
            );
            
            $company_id = $stmt->fetchColumn();
            
            $db->commit();
            (new ApiResponse(200, "Company and user created successfully.", ["company_id" => $company_id, "user_id" => $user_id]))->toJson();
        } catch (Exception $e) {
            $db->rollBack();
            (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
        }
    });

    $router->add('POST', '/master/companies/delete', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "d");

        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!isset($data["company_id"]) || !is_numeric($data["company_id"])) {
            (new ApiResponse(400, "Invalid company ID."))->toJson();
            return;
        }
        
        $company_id = (int) $data["company_id"];
        $db = new Database();
        
        try {
            $db->beginTransaction();
            
            $stmt = $db->query("SELECT id FROM companies WHERE id = ?", [$company_id]);
            if (!$stmt->fetch(PDO::FETCH_ASSOC)) {
                (new ApiResponse(404, "Company not found."))->toJson();
                return;
            }
            
            $db->query("DELETE FROM companies WHERE id = ?", [$company_id]);
            
            $db->commit();
            (new ApiResponse(200, "Company deleted successfully."))->toJson();
        } catch (Exception $e) {
            $db->rollBack();
            (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
        }
    });
?>
