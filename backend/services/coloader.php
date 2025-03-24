<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ .'/../core/Handler.php';

    global $router;
    // Get list of coloader with pagination
    $router->add('POST', '/master/coloader', function () {
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $payload = (object) [
            "fields" => [],
            "max" => 10,
            "current" => 1
        ];
        $data = json_decode(file_get_contents("php://input"), true);
        if (!empty($data)) {
            $payload = (object) $data; 
        }

        $db = new Database();
        $sql = $db->generateDynamicQuery("coloader", $payload->fields)." WHERE branch_id = ? ORDER BY city_name ASC LIMIT ? OFFSET ?";
        $stmt = $db->query($sql, [$_info->branch_id ,$payload->max, $payload->current]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$list) {
            $list = [];
        }

        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });

    // Add a new coloader
    $router->add('POST', '/master/coloader/new', function () {
        $pageID=10;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "w");
    
        $data = json_decode(file_get_contents("php://input"), true);

    
        $db = new Database();

        $stmt = $db->query("insert into coloader ( coloader_name, coloader_contuct, coloader_address, coloader_postal_code, coloader_email, coloader_city, coloader_branch)values(?, ?, ?, ?, ?, ?, ?);",
        [
            $data["coloader_name"], 
            $data["coloader_contuct"], 
            $data["coloader_address"],    
            $data["coloader_postal_code"],
            $data["coloader_email"],
            $data["coloader_city"],    
            $_info->branch_id


        ]);
        if($stmt){
            (new ApiResponse(200, "Success", null)).toJson();
        }
        (new ApiResponse(200, "Faild to create coloader",null)).toJson();
    });
    

    // Delete a coloader by ID
    $router->add('POST', '/master/coloader/delete', function () {
        $pageID=10;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "d");

        $data = json_decode(file_get_contents("php://input"), true);

        $db = new Database();
        // Delete the city
        $stmt = $db->query("delete from coloader where coloader_id = ?;",[$data["coloader_id"]]);
        $response = new ApiResponse(200, "City deleted successfully.");
        $response->toJson();
    });

    // UPDATE DB 
    $router->add('POST', '/master/coloader/update', function () {
        $pageID = 3;
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();
        $handler->validatePermission($pageID, $_info->user_id, "u"); // "d" for delete permission
    
        $payload = (object) [
            "updates" => [
                'coloader_name' => 'Error'
            ],
            "conditions" => 'coloader_id=0'
        ];
    
        $data = json_decode(file_get_contents("php://input"), true);
    
    
        if (!empty($data)) {
            $payload = (object) $data;
        }
    
        $db = new Database();
        $sql = $db->generateDynamicUpdate("coloader", $payload->updates, $payload->conditions);

    
        try {
            $stmt = $db->query($sql[0], $sql[1]);
    
            if ($stmt->rowCount() > 0) {
                (new ApiResponse(200,"Update successful", $stmt->rowCount()))->toJson();
            } else {
                (new ApiResponse(500,"No rows updated"))->toJson();
            }
        } catch (Exception $e) {
            (new ApiResponse(500,"Update failed",  $e->getMessage()))->toJson();
        }
    
    
    
    })
?>
