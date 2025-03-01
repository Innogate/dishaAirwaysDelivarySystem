<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ . '/../core/Handler.php';
    
    global $router;
    global $pageID;
    
    $pageID = 5;
    // GET ALL COMPANIES LIST
    $router->add('POST', '/master/companies', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["from"]); // Ensure 'from' is provided
    
        $db = new Database();
        $stmt = $db->query("SELECT id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no 
                            FROM companies LIMIT 10 OFFSET ?", [$data["from"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        (new ApiResponse(200, "Success", $list ?: []))->toJson();
    });
    
    // GET COMPANIES BY ID
    $router->add('POST', '/master/companies/byId', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");
    
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["company_id"]);
    
        $db = new Database();
        $stmt = $db->query("SELECT id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no FROM companies WHERE id = ?", [$data["company_id"]]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC);
    
        if (!$list) {
            (new ApiResponse(404, "Invalid company ID", ""))->toJson();
        } else {
            (new ApiResponse(200, "Success", $list))->toJson();
        }
    });
    
    // GET COMPANIES BY STATE
    $router->add('POST', '/master/companies/byState', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");
    
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["state_id"]);
    
        $db = new Database();
        $stmt = $db->query("SELECT id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no FROM companies WHERE state_id = ?", [$data["state_id"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        (new ApiResponse(200, "Success", $list ?: []))->toJson();
    });
    
    // GET COMPANIES BY CITY
    $router->add('POST', '/master/companies/byCityId', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");
    
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["city_id"]);
    
        $db = new Database();
        $stmt = $db->query("SELECT id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no FROM companies WHERE city_id = ?", [$data["city_id"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        (new ApiResponse(200, "Success", $list ?: []))->toJson();
    });
    
    // GET COMPANIES BY STATE AND CITY
    $router->add('POST', '/master/companies/byCityAndState', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "r");
    
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["state_id", "city_id"]);
    
        $db = new Database();
        $stmt = $db->query("SELECT id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no FROM companies WHERE state_id = ? AND city_id = ?", [$data["state_id"], $data["city_id"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        (new ApiResponse(200, "Success", $list ?: []))->toJson();
    });
    
    // ADD NEW COMPANY
    $router->add('POST', '/master/companies/new', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "w");
    
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["name", "address", "city_id", "state_id", "pin_code", "contact_no", "email", "gst_no", "cin_no", "udyam_no", "logo"]);
    
        $db = new Database();
        try {
            $db->beginTransaction();
    
            $stmt = $db->query("INSERT INTO companies (name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_by) 
                                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id", 
                                [$data["name"], $data["address"], $data["city_id"], $data["state_id"], $data["pin_code"],
                                 $data["contact_no"], $data["email"], $data["gst_no"], $data["cin_no"], $data["udyam_no"],
                                 $data["logo"], $_info->user_id]);
    
            $company_id = $stmt->fetchColumn();
            $db->commit();
    
            (new ApiResponse(200, "Company created successfully.", ["company_id" => $company_id]))->toJson();
        } catch (Exception $e) {
            $db->rollBack();
            (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
        }
    });
    
    // DELETE COMPANY
    $router->add('POST', '/master/companies/delete', function () {
        global $pageID;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "d");
    
        $data = json_decode(file_get_contents("php://input"), true);
        $handler->validateInput($data, ["company_id"]);
    
        $db = new Database();
        try {
            $db->beginTransaction();
            $stmt = $db->query("DELETE FROM companies WHERE id = ?", [$data["company_id"]]);
            $db->commit();
            (new ApiResponse(200, "Company deleted successfully."))->toJson();
        } catch (Exception $e) {
            $db->rollBack();
            (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
        }
    });
    
?>