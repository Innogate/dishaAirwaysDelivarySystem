<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ . '/../core/Handler.php';

    global $router;
    // ** GET ALL BRANCH TOKEN FOR BOOKING
    $router->add('POST', '/credit/token', function () {
        $pageID=9;
        $db = new Database();
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();

        $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page
        $data = json_decode(file_get_contents("php://input"), true);
        $require_filed = [ "max", "current"];
        $handler->validateInput($data, $require_filed);
        $sql = "SELECT credit_node.*, branches.branch_name as branch_name, cities.city_name as city_name FROM credit_node JOIN branches ON credit_node.branch_id = branches.branch_id JOIN cities ON branches.city_id = cities.city_id LIMIT ? OFFSET ?";
        $stmt = $db->query($sql, [$data["max"], $data["current"]]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
        (new ApiResponse(200, "Success", $list))->toJson();
    }); 
    
    // ** GET TOKEN BY ID
    $router->add("POST", "/credit/token/byId", function () {
        $pageID=9;
        $db = new Database();
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();

        $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w"); // Check user permission for this page
        $data = json_decode(file_get_contents("php://input"), true);
        $require_filed = ["token_id"];
        $handler->validateInput($data, $require_filed);
        $sql = "SELECT * FROM credit_node WHERE credit_node_id = ?";
        $stmt = $db->query($sql, [$data["token_id"]]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
        (new ApiResponse(200, "Success", $list))->toJson();
    });

    // ** CREATE NEW TOKEN
    $router->add("POST", "/credit/token/new", function () {
        $pageID=9;
        $db = new Database();
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();

        $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");
        $data = json_decode(file_get_contents("php://input"), true);
        $require_filed = ["branch_id", "start_no", "end_no"];
        $handler->validateInput($data, $require_filed);

        
        $sql = "INSERT INTO credit_node (branch_id, start_no, end_no) VALUES
        (?, ?, ?) RETURNING credit_node_id";
        $stmt = $db->query($sql, [$data["branch_id"], $data["start_no"], $data["end_no"]]);
        $list = $stmt->fetchColumn();
        if(!$list){
            (new ApiResponse(400, "Failed to create. try again"))->toJson();
        }
        (new ApiResponse(200, "Success", $list))->toJson();
    });

    $router->add("POST", "/credit/token/delete", function () {
        $pageID=9;
        $db = new Database();
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();

        $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");
        $data = json_decode(file_get_contents("php://input"), true);
        $require_filed = ["token_id"];
        $handler->validateInput($data, $require_filed);

        // check token exist or not 
        $sql = "SELECT * FROM credit_node WHERE credit_node_id = ?";
        $stmt = $db->query($sql, [$data["token_id"]]);
        $list = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];
        if (empty($list)) {
            (new ApiResponse(400, "Error", "Token Not Found"))->toJson();
            return;
        }

        $sql = "DELETE FROM credit_node WHERE credit_node_id = ?;";
        $stmt = $db->query($sql, [$data["token_id"]]);
        (new ApiResponse(200, "Success", "Token Delete Successfully"))->toJson();
    });
?>