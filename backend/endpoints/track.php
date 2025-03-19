<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ .'/../core/Handler.php';

    global $pageID;

    // GET BY SLIP ID
    $router->add("POST", '/track/bySlipId', function () {
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();  // Ensure this throws an error or returns an error response if validation fails

        // Get and validate input
        $data = json_decode(file_get_contents("php://input"), true);
        $required_fields = ["slip_no"];
        $handler->validateInput($data, $required_fields);
        
        // Prepare database query
        $db = new Database();
        $sql = "SELECT * FROM tracking WHERE slip_no = ?";
        $stmt = $db->query($sql , [$data["slip_no"]]);

        // Fetch and handle result
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$list) {
            $list = [];  // Return an empty array if no results
        }

        // Send response
        $response = new ApiResponse(200, "Success", $list);
        $response->toJson();
    });
    
    // Update tracking status
    $router->add("POST","/track/update", function () {
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();  // Ensure this throws an error or returns an error response if validation fails

        // Get and validate input
        $data = json_decode(file_get_contents("php://input"), true);
        $required_fields = ["status", "slip_no"];
        $handler->validateInput($data, $required_fields);

        // Prepare database query
        $db = new Database();
        $sql = "UPDATE tracking SET status = ? WHERE slip_no = ?";
        
        // Execute query and check result
        $stmt = $db->query($sql , [$data["status"], $data["slip_no"]]);

        // Check if the update was successful (affected rows)
        if ($stmt->rowCount() > 0) {
            // Successful update
            $response = new ApiResponse(200, "Status updated successfully", null);
            $response->toJson();
        } else {
            // If no rows were affected, return an error
            $response = new ApiResponse(400, "Update failed: Slip not found or no change detected", null);
            $response->toJson();
        }
    });
?>
