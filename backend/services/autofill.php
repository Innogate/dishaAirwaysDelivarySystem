<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
$router->add('POST', '/autofill/newBooking', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $data = json_decode(file_get_contents("php://input"), true);

    $db = new Database();
    $search = $data["search"] . "%";

    $sql = "
    SELECT 
        LOWER(b.consignee_name) AS consignee_name,
        b.consignee_mobile,
        b.destination_city_id,
        LOWER(b.consignor_name) AS consignor_name,
        b.consignor_mobile,
        b.destination_branch_id
    FROM bookings b
    WHERE 
        LOWER(b.consignee_name) LIKE LOWER(?) 
        OR b.consignee_mobile LIKE ? 
        OR LOWER(b.consignor_name) LIKE LOWER(?) 
        OR b.consignor_mobile LIKE ?
    ORDER BY consignee_name ASC
    LIMIT 100
    ";

    $stmt = $db->query($sql, [$search, $search, $search, $search]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Deduplicate purely by consignee_name + consignor_name in PHP
    $unique = [];
    $finalList = [];

    foreach ($list as $row) {
        $key = strtolower(trim($row['consignee_name'])) . "|" . strtolower(trim($row['consignor_name']));
        if (!isset($unique[$key])) {
            $unique[$key] = true;
            $finalList[] = $row;
        }
    }

    $response = new ApiResponse(200, "Success", $finalList);
    $response->toJson();
});
?>
