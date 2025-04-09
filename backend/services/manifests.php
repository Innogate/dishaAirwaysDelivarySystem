<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;

// Get all manifests
$router->add('POST', '/manifests', function () {
    $pageID = 11;
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
    if (!empty($data)) $payload = (object) $data;
    $limit = (int) $payload->max;
    $offset = (int) $payload->current;
    $db = new Database();
    $baseQuery = $db->generateDynamicQuery("manifests", $payload->fields) . " WHERE deleted = FALSE ";
    $sql = $baseQuery . ($isAdmin && $_info->branch_id == null 
        ? "LIMIT $limit OFFSET $offset" 
        : "AND branch_id = ? LIMIT $limit OFFSET $offset");

    $params = ($isAdmin && $_info->branch_id == null)
        ? []
        : [$_info->branch_id];

    $stmt = $db->query($sql, $params);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    foreach ($list as &$row) {
        if (!empty($row["booking_id"])) {
            $row["booking_id"] = explode(",", $row["booking_id"]);
            $row["booking_id"] = array_map('intval', $row["booking_id"]);
        }
    }

    (new ApiResponse(200, "manifests", $list))->toJson();
});

// Get manifest by ID
$router->add('POST', '/manifests/byId', function () {
    $pageID = 11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $payload = (object) [
        "fields" => [],
        "manifests_id" => 0,
    ];

    $data = json_decode(file_get_contents("php://input"), true);
    if (!empty($data)) $payload = (object) $data;

    $db = new Database();
    $sql_fetch = "SELECT 
        m.*, 
        br.branch_name AS origin_branch,
        dbr.branch_name AS destination_branch,
        c.coloader_name
    FROM manifests m
    JOIN branches br ON m.branch_id = br.branch_id 
    JOIN branches dbr ON m.destination_id = dbr.branch_id 
    JOIN coloader c ON m.coloader_id = c.coloader_id
    WHERE m.manifest_id = ?";
    $insertedData = $db->query($sql_fetch, [$payload->manifests_id])->fetch(PDO::FETCH_ASSOC);

    $insertedData["booking_id"] = explode(",", $insertedData["booking_id"]);
    $insertedData["booking_id"] = array_map('intval', $insertedData["booking_id"]);

    foreach ($insertedData["booking_id"] as $booking_id) {
        $sql_fetch = "SELECT 
            b.*, 
            br.branch_name AS branch_name, 
            dbr.city_name AS destination_city_name
        FROM bookings b
        JOIN branches br ON b.branch_id = br.branch_id
        JOIN cities dbr ON b.destination_city_id = dbr.city_id
        WHERE b.booking_id = ?";
        $booking = $db->query($sql_fetch, [$booking_id])->fetch(PDO::FETCH_ASSOC);
        $insertedData["bookings"][] = $booking;
    }

    (new ApiResponse(200, "Success", $insertedData))->toJson();
});

// Create new manifest
$router->add('POST', '/manifests/new', function () {
    $pageID = 11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);
    $requiredFields = ["coloader_id", "booking_id", "destination_id", "bag_count", "destination_city_id"];
    $handler->validateInput($data, $requiredFields);

    $db = new Database();

    if ($_info->branch_id == null) {
        (new ApiResponse(400, "It's not a branch account", "", 400))->toJson();
        return;
    }

    try {
        $db->beginTransaction();

        $booking_ids_array = is_array($data["booking_id"]) ? $data["booking_id"] : [$data["booking_id"]];
        $booking_ids_string = implode(",", array_map('intval', $booking_ids_array));

        // GENERATE MANIFEST NUMBER
        $sql = "SELECT manifest_sires FROM branches WHERE branch_id = ?";
        $manifest_series = $db->query($sql, [$_info->branch_id])->fetchColumn();
        $splitResult = splitString($manifest_series);
        $prefix = $splitResult['prefix'] . "%";

        $sql = "SELECT manifests_number FROM manifests WHERE manifests_number LIKE ? ORDER BY manifest_id DESC LIMIT 1";
        $stmt = $db->query($sql, [$prefix]);
        if ($stmt->rowCount()) {
            $manifest_series = $stmt->fetchColumn();
        }
        $manifest_series = splitAndIncrement($manifest_series);

        $sql = "INSERT INTO manifests (coloader_id, booking_id, destination_id, branch_id, manifests_number, bag_count, destination_city_id) 
                VALUES (?, ?, ?, ?, ?, ?, ?)";
        $db->query($sql, [
            $data["coloader_id"],
            $booking_ids_string,
            $data["destination_id"],
            $_info->branch_id,
            $manifest_series,
            $data["bag_count"],
            $data["destination_city_id"]
        ]);

        $lastId = $db->pdo->lastInsertId();

        foreach ($booking_ids_array as $booking_id) {
            $db->query("UPDATE bookings SET status = 2, manifest_id = ? WHERE booking_id = ?", [
                $manifest_series, $booking_id
            ]);
            $db->query("UPDATE received_booking SET status = FALSE WHERE booking_id = ?", [$booking_id]);
            $db->query("INSERT INTO tracking (current_branch_id, destination_branch_id, booking_id, departed_at)
                        VALUES (?, ?, ?, NOW())", [$_info->branch_id, $data["destination_id"], $booking_id]);
        }

        $db->commit();

        $sql_fetch = "SELECT * FROM manifests WHERE manifest_id = ?";
        $insertedData = $db->query($sql_fetch, [$lastId])->fetch(PDO::FETCH_ASSOC);
        $insertedData["booking_id"] = explode(",", $insertedData["booking_id"]);
        $insertedData["booking_id"] = array_map('intval', $insertedData["booking_id"]);

        foreach ($insertedData["booking_id"] as $booking_id) {
            $sql_fetch = "SELECT 
                b.*, 
                br.branch_name AS branch_name, 
                dbr.branch_name AS destination_branch_name
            FROM bookings b
            JOIN branches br ON b.branch_id = br.branch_id
            JOIN branches dbr ON b.destination_branch_id = dbr.branch_id
            WHERE b.booking_id = ?";
            $booking = $db->query($sql_fetch, [$booking_id])->fetch(PDO::FETCH_ASSOC);
            $insertedData["bookings"][] = $booking;
        }

        (new ApiResponse(200, "Manifest created successfully.", $insertedData))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// Delete manifest
$router->add('POST', '/manifests/delete', function () {
    $pageID = 11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "d");

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["manifest_id"]);
    $db = new Database();

    try {
        $db->beginTransaction();
        $sql = "SELECT booking_id FROM manifests WHERE manifest_id = ?";
        $booking_ids = $db->query($sql, [$data["manifest_id"]])->fetchColumn();

        $db->query("UPDATE manifests SET deleted = TRUE WHERE manifest_id = ?", [$data["manifest_id"]]);

        $booking_ids = explode(",", trim($booking_ids));
        foreach ($booking_ids as $booking_id) {
            $db->query("DELETE FROM tracking WHERE current_branch_id = ? AND booking_id = ?", [$_info->branch_id, $booking_id]);
        }

        $db->commit();
        (new ApiResponse(200, "Manifest deleted successfully."))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});

// Manifests list of available bookings
$router->add('POST', '/manifests/bookings', function () {
    $pageID = 11;
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission($pageID, $_info->user_id, "r");

    $db = new Database();

    try {
        $db->beginTransaction();
        $sql = "SELECT b.* FROM bookings b 
                LEFT JOIN manifests m ON FIND_IN_SET(b.booking_id, m.booking_id) 
                WHERE b.branch_id = ? AND m.manifest_id IS NULL AND b.status NOT IN (3, 4)
                UNION
                SELECT b.* FROM received_booking rb 
                JOIN bookings b ON rb.booking_id = b.booking_id 
                LEFT JOIN manifests m ON FIND_IN_SET(b.booking_id, m.booking_id) 
                WHERE rb.branch_id = ? AND b.status = 5";

        $stmt = $db->query($sql, [$_info->branch_id, $_info->branch_id]);
        $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $db->commit();
        (new ApiResponse(200, "Success", $list))->toJson();
    } catch (Exception $e) {
        $db->rollBack();
        (new ApiResponse(500, "Server error: " . $e->getMessage()))->toJson();
    }
});
?>
