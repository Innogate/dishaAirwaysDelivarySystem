<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
// get all manifests // ? DONE
$router->add('POST', '/manifests', function () {
    $pageID=7;
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
    (new ApiResponse(200, "manifests", $list))->toJson();
});

// get manifests by id // ? DONE
$router->add('POST', '/manifests/byId', function () {
    $pageID=7;
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
        (new ApiResponse(400, "Invalid Employee ID", "", 400))->toJson();
    }
    (new ApiResponse(200, "Success", $list))->toJson();
});

// create new manifests // ? DONE
$router->add('POST', '/manifests/new', function () {
    $pageID=7;
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

    if($_info->branch_id==null){
        (new ApiResponse(400,"It'n a branch account","",400))->toJson();
        return;
    }

    try {
        $db->beginTransaction();

        $sql = "INSERT INTO manifests (coloader_id, booking_id, destination_id, branch_id) VALUES (?, ?, ?, ?) RETURNING manifest_id";
        $stmt = $db->query($sql, [$data["coloader_id"], $data["booking_id"], $data["destination_id"], $_info->branch_id]);
        if($stmt->rowCount()== 0){
            $db->rollBack();
            (new ApiResponse(500, "Server error"))->toJson();
            return;
        }

        //  change bookings status
        $db->query("UPDATE bookings SET status = 1 WHERE booking_id in ?", [$data["booking_id"]]);

        // update status false of this booking id exist on received_booking
        $db->query("UPDATE received_bookings SET status = FALSE WHERE booking_id in ?", params: [$data["booking_id"]]);

        // ADD tracking
        foreach($data["booking_id"] as $booking_id){
            $db->query("INSERT INTO tracking (current_branch_id, destination_branch_id, booking_id) VALUES (?, ?, ?)", params: [
                $_info->branch_id,
                $data["destination_id"],
                $booking_id,
            ]);
        }

        $db->commit();
        $manifest_id = $stmt->fetch(PDO::FETCH_ASSOC)["manifest_id"];
        (new ApiResponse(200, "Manifest created successfully.", $manifest_id))->toJson();
    }
    catch(Exception $e){
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// DELETE manifests // ? DONE
$router->add('POST', '/manifests/delete', function () {
    $pageID=7;
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
?>
