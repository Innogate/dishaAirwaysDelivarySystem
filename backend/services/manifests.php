<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
// get all manifests // ? DONE
$router->add('POST', '/manifests', function () {
    $pageID=11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $isAdmin = $handler->validatePermission($pageID, $_info->user_id, "r");
    $payload = (object) [
        "fields" => [],
        "max" => 10,
        "current" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    if ($isAdmin && $_info->branch_id==null) {
        $sql = $db->generateDynamicQuery("manifests", $payload->fields) . " WHERE deleted = FALSE  LIMIT    ?    OFFSET     ?";
        $stmt = $db->query($sql, [$payload->max, $payload->current]);
    } else {
        $sql = $db->generateDynamicQuery("manifests", $payload->fields) . " WHERE deleted = FALSE AND branch_id = ?  LIMIT    ?    OFFSET     ?";
        $stmt = $db->query($sql, [$_info->branch_id, $payload->max, $payload->current]);
    }
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    // Convert "booking_id" from "{3,4,5}" to an array [3,4,5]
    foreach ($list as &$row) {
        if (isset($row["booking_id"])) {
            $row["booking_id"] = str_getcsv(trim($row["booking_id"], "{}"));
            $row["booking_id"] = array_map('intval', $row["booking_id"]); // Convert to integers
        }
    }
    (new ApiResponse(200, "manifests", $list))->toJson();
});

// get manifests by id // ? DONE
$router->add('POST', '/manifests/byId', function () {
    $pageID=11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object) [
        "fields" => [],
        "manifests_id" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) {
        $payload = (object) $data;
    }

    $db = new Database();
    $sql = $db->generateDynamicQuery("manifests", $payload->fields) . " WHERE manifest_id = ?";
    $stmt = $db->query($sql, [$payload->manifests_id]);
    $list = $stmt->fetch(PDO::FETCH_ASSOC);
    if(!$list){
        (new ApiResponse(400, "Invalid manifest ID", "", 400))->toJson();
    }
    (new ApiResponse(200, "Success", $list))->toJson();
});

// create new manifests // ? DONE
$router->add('POST', '/manifests/new', function () {
    $pageID = 11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);

    $requiredFields = [
        "coloader_id", 
        "booking_id",
        "destination_id",
    ];
    
    $handler->validateInput($data, $requiredFields);
    
    $db = new Database();

    if ($_info->branch_id == null) {
        (new ApiResponse(400, "It's not a branch account", "", 400))->toJson();
        return;
    }
    
    try {
        $db->beginTransaction();
        // convert booking_id to array
        if (!is_array($data["booking_id"])) {
            $data["booking_id"] = [$data["booking_id"]];
        }
        $booking_ids = '{' . implode(',', array_map('intval', $data["booking_id"])) . '}';
        
        // GET MANIFEST SERIES from branches manifest_sires
        $sql = "SELECT manifest_sires FROM branches WHERE branch_id = ?";
        $stmt = $db->query($sql, [$_info->branch_id]);
        $manifest_series = $stmt->fetchColumn();
        $manifest_series = splitAndIncrement($manifest_series);

        $sql = "INSERT INTO manifests (coloader_id, booking_id, destination_id, branch_id, manifests_number) 
                VALUES (?, ?, ?, ?)";
        $db->query($sql, [$data["coloader_id"], $booking_ids, $data["destination_id"], $_info->branch_id, $manifest_series]);

        // Change bookings status
        $db->query("UPDATE bookings SET status = 1 WHERE booking_id = ANY(?)", [$booking_ids]);

        // Update status to false in received_bookings
        $db->query("UPDATE received_booking SET status = FALSE WHERE booking_id = ANY(?)", [$booking_ids]);

        // Add tracking entries
        foreach ($data["booking_id"] as $booking_id) {
            $db->query("INSERT INTO tracking (current_branch_id, destination_branch_id, booking_id) 
                        VALUES (?, ?, ?)", [$_info->branch_id, $data["destination_id"], $booking_id]);
        }

        $db->commit();
        (new ApiResponse(200, "Manifest created successfully.", []))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});


// DELETE manifests // ? DONE
$router->add('POST', '/manifests/delete', function () {
    $pageID=11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);

    $requiredFields = [
        "manifest_id",
    ];
    
    $handler->validateInput($data, $requiredFields);
    $db = new Database();

    try {
        $db->beginTransaction();
        $stmt = $db->query("UPDATE manifests SET deleted = TRUE WHERE manifest_id = ? RETURNING booking_id", [$data["manifest_id"]]);
        if($stmt->rowCount()== 0){
            $db->rollBack();
            (new ApiResponse(500, "Server error"))->toJson();
            return;
        }

        $booking_id = $stmt->fetch(PDO::FETCH_ASSOC)["booking_id"];

        //  delete tracking
        $db->query("DELETE FROM tracking WHERE branch_id = ? AND booking_id in ?", [$_info->branch_id,$booking_id]);
        $db->commit();
        (new ApiResponse(200, "Manifest deleted successfully."))->toJson();
    }
    catch(Exception $e){
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// MANIFESTS LIST OF BOOKINGS //? DONE
$router->add('POST', '/manifests/bookings', function () {
    $pageID=11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    $db = new Database();
    try {
        $db->beginTransaction();
        // give all booking list that don't have manifests booking_id in booking_id list on brach_id = $_info->branch_id
        $sql = "WITH bookings_not_in_manifest AS (
    SELECT b.*
    FROM bookings b
    LEFT JOIN manifests m ON ARRAY[b.booking_id] <@ m.booking_id
    WHERE b.branch_id = ?
    AND m.manifest_id IS NULL
),
received_bookings_not_in_manifest AS (
    SELECT b.*
    FROM received_booking rb
    JOIN bookings b ON rb.booking_id = b.booking_id
    LEFT JOIN manifests m ON ARRAY[b.booking_id] <@ m.booking_id
    WHERE rb.branch_id = ?
    AND m.manifest_id IS NULL
)
SELECT * FROM bookings_not_in_manifest
UNION 
SELECT * FROM received_bookings_not_in_manifest;
";
        $stmt = $db->query($sql, [$_info->branch_id, $_info->branch_id]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $db->commit();
        (new ApiResponse(200, "Success", $list))->toJson();
    }
    catch(Exception $e){
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
})
?>
