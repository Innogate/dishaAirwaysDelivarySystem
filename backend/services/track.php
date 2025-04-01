<?php
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ .'/../core/Handler.php';

    // GET BY SLIP ID
    $router->add("POST", '/track/bySlipId', function () {
        $jwt = new JwtHandler();
        $handler = new Handler();
        $_info = $jwt->validate();

        // Get and validate input
        $data = json_decode(file_get_contents("php://input"), true);
        $required_fields = ["slip_no"];
        $handler->validateInput($data, $required_fields);
        $db = new Database();
        
        // GET BOOKING ID BY SLIP ID
        $sql = "SELECT  consignee_name,
        consignor_name,
        slip_no,
        package_count,
        package_weight,
        booking_address,
        paid_type,
        total_value,
        created_at as booking_date, booking_id FROM bookings WHERE slip_no = ?";
        $stmt = $db->query($sql, [$data["slip_no"]]);
        $booking = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$booking) {
            $response = new ApiResponse(404, "Invalid Slip No");
            $response->toJson();
            exit;
            
        }
        $booking_id = $booking["booking_id"];
        // Prepare database query
       
        $sql = "SELECT 
        received,
        arrived_at,
        departed_at,
        b.branch_name as source_branch_name, 
        bb.branch_name as destination_branch_name
        FROM tracking
        JOIN branches b ON current_branch_id = b.branch_id 
        JOIN branches bb ON destination_branch_id = bb.branch_id  
        WHERE booking_id = ?";
        $stmt = $db->query($sql , [$booking_id]);

        // Fetch and handle result
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if (!$list) {
            $list = [];  // Return an empty array if no results
        }

        // remove booking_id from result
        unset($booking["booking_id"]);

        // Send response
        $data = ["status" => $list, "booking"=> $booking];
        $response = new ApiResponse(200, "Success", $data);
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
