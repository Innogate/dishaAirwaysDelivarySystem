<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
$router->add('POST', '/pods', function () {
    $pageID=13;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");
    $required_fields = ["limit", "current"];
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, $required_fields);
    if (!empty($data)) {
        $data = (array) $data;
    }
    $limit = $data["limit"];
    $current = $data["current"];

    $db = new Database();
    if ($isAdmin && $_info->branch_id == null) {
        $sql = "SELECT b.*
        FROM bookings as b
        JOIN pods as pod ON b.booking_id = pod.booking_id 
        LIMIT $limit OFFSET $current";
        $stmt = $db->query($sql, []);
    }
    else{
        $sql = "SELECT * FROM bookings JOIN pods ON bookings.booking_id = pods.booking_id  WHERE bookings.branch_id = ? LIMIT $limit OFFSET $offset";
        $stmt = $db->query($sql, [$_info->branch_id]);
    }
    
   
    $pods = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];
    if (!empty($pod['pod_data'])) {
        $pod['pod_data'] = base64_encode($pod['pod_data']);
    }

    // Send the response with Base64-encoded pod_data
    (new ApiResponse(200, "Success", $pods))->toJson();
});

$router->add('POST', '/pods/byId', function () {
    $pageID = 13;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $required_fields = ["booking_id"];
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, $required_fields);

    $db = new Database();
    $sql = "SELECT * FROM pods WHERE booking_id = ?";
    $stmt = $db->query($sql, [$data["booking_id"]]);

    $pod = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($pod && !empty($pod['pod_data'])) {
        $base64 = base64_encode($pod['pod_data']);

        // Infer MIME type from `data_formate` column
        $format = strtolower(trim($pod['data_formate']));
        $mimeTypeMap = [
            'jpg' => 'image/jpeg',
            'jpeg' => 'image/jpeg',
            'png' => 'image/png',
            'pdf' => 'application/pdf',
        ];
        $mimeType = $mimeTypeMap[$format] ?? 'application/octet-stream';

        $pod['pod_data'] = "data:$mimeType;base64,$base64";
    }

    (new ApiResponse(200, "Success", $pod ?: []))->toJson();
});



$router->add("POST", "/pods/new", function () {
    $pageID = 13;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    if ($_info->branch_id === null) {
        (new ApiResponse(403, "Access denied, not logged into a branch account"))->toJson();
        exit;
    }

    $required_fields = ["booking_id", "pod_data", "data_formate"];
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, $required_fields);

    $booking_id = $data["booking_id"];
    $base64PodData = $data["pod_data"];
    $fileType = strtolower(trim($data["data_formate"]));
    $city_id = $data["city_id"] ?? null;

    // Decode base64
    $podBlob = base64_decode(preg_replace('#^data:.*?base64,#', '', $base64PodData));

    if ($podBlob === false) {
        (new ApiResponse(400, "Invalid base64-encoded POD data"))->toJson();
        exit;
    }

    $db = new Database();

    // Validate booking
    $sql = "SELECT b.booking_id FROM bookings AS b
            JOIN received_booking AS rb ON b.booking_id = rb.booking_id
            WHERE b.status != 6 AND b.booking_id = ? AND rb.branch_id = ? LIMIT 1";
    $stmt = $db->query($sql, [$booking_id, $_info->branch_id]);
    $booking = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$booking) {
        (new ApiResponse(404, "Invalid or unauthorized booking ID"))->toJson();
        exit;
    }

    // Check if POD exists
    $sql = "SELECT pod_id FROM pods WHERE booking_id = ? LIMIT 1";
    $stmt = $db->query($sql, [$booking_id]);
    $existingPod = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($existingPod) {
        // Update
        $sql = "UPDATE pods SET pod_data = ?, data_formate = ?, created_by = ?, branch_id = ?  WHERE pod_id = ?";
        $db->query($sql, [$podBlob, $fileType, $_info->user_id, $_info->branch_id, $existingPod["pod_id"]]);
        (new ApiResponse(200, "POD updated successfully"))->toJson();
    } else {
        // Insert
        $sql = "INSERT INTO pods (booking_id, pod_data, data_formate, created_by, branch_id)
                VALUES (?, ?, ?, ?, ?)";
        $db->query($sql, [$booking_id, $podBlob, $fileType, $_info->user_id, $_info->branch_id]);

        if ($db->lastInsertId() > 0) {
            (new ApiResponse(200, "POD uploaded successfully"))->toJson();
        } else {
            (new ApiResponse(500, "Failed to upload POD"))->toJson();
        }
    }
});


?>
