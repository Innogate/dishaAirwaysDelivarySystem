<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
$router->add('POST', '/pods', function () {
    $pageID = 1;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");

    $db = new Database();

    if ($isAdmin) {
        $sql = "SELECT * FROM pods ORDER BY created_at DESC";
        $stmt = $db->query($sql);
    } else {
        $sql = "SELECT * FROM pods WHERE branch_id = ? ORDER BY created_at DESC";
        $stmt = $db->query($sql, [$_info->branch_id]);
    }

    $pods = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    // Base64 encode the pod_data before sending the response
    foreach ($pods as &$pod) {
        // Check if pod_data exists and is not empty
        if (!empty($pod['pod_data'])) {
            $pod['pod_data'] = base64_encode($pod['pod_data']);
        }
    }

    // Send the response with Base64-encoded pod_data
    (new ApiResponse(200, "Success", $pods))->toJson();
});


$router->add("POST", "/pods/new", function () {
    $pageID = 13;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    // If the user is not an admin or is not logged into a branch account, deny access
    if ($isAdmin || $_info->branch_id == null) {
        (new ApiResponse(403, "Access denied, not logged into a branch account"))->toJson();
    }

    $required_fields = ["booking_id", "pod_data", "data_formate"];
    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $data = (array) $data;
    }

    $handler->validateInput($data, $required_fields);

    $booking_id = $data["booking_id"];
    $base64PodData = $data["pod_data"];
    $fileType = $data["data_formate"];

    $podBlob = base64_decode($base64PodData);

    // Validate booking
    $db = new Database();
    $sql = "SELECT b.booking_id FROM bookings AS b
            JOIN received_booking AS rb ON b.booking_id = rb.booking_id
            WHERE b.status != 6 AND b.booking_id = ? AND rb.branch_id = ? LIMIT 1";
    $stmt = $db->query($sql, [$booking_id, $_info->branch_id]);
    $booking = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$booking) {
        (new ApiResponse(404, "Invalid or unauthorized booking ID"))->toJson();
        exit;
    }

    // Insert the pod data (binary file) into the database
    $sql = "INSERT INTO pods (booking_id, pod_data, data_formate, created_by, branch_id) VALUES (?, ?, ?, ?, ?)";
    $db->query($sql, [$booking_id, $podBlob, $fileType, $_info->user_id, $_info->branch_id]);

    // Check if the insertion was successful
    if ($db->lastInsertId() > 0) {
        (new ApiResponse(200, "POD uploaded successfully"))->toJson();
    } else {
        (new ApiResponse(500, "Failed to upload POD"))->toJson();
    }
});

?>
