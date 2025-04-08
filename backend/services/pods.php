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
    (new ApiResponse(200, "Success", $pods))->toJson();
});

$router->add("POST", "/pods/new", function () {
    $pageID = 13;
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "w");

    if ($isAdmin || $_info->branch_id == null) {
        (new ApiResponse(403, "Access denied, not logged into a branch account"))->toJson();
    }

    if (!isset($_POST["booking_id"]) || !isset($_FILES["pod_data"])) {
        (new ApiResponse(400, "Missing booking_id or file"))->toJson();
        exit;
    }

    $booking_id = $_POST["booking_id"];
    $podFile = $_FILES["pod_data"]["tmp_name"];
    $fileType = $_FILES["pod_data"]["type"];

    if (!file_exists($podFile)) {
        (new ApiResponse(400, "File upload failed"))->toJson();
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

    $podBlob = file_get_contents($podFile);

    // Insert including data_formate
    $sql = "INSERT INTO pods (booking_id, pod_data, data_formate, created_by) VALUES (?, ?, ?, ?)";
    $db->query($sql, [$booking_id, $podBlob, $fileType, $_info->user_id]);

    if ($db->lastInsertId() > 0) {
        (new ApiResponse(200, "POD uploaded successfully"))->toJson();
    } else {
        (new ApiResponse(500, "Failed to upload POD"))->toJson();
    }
});

?>