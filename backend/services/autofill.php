<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
$router->add('GET', '/autofill/newBooking', function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();



    $db = new Database();
    $sql = "SELECT consignee_name, consignor_name, destination_city_id, destination_branch_id, COUNT(*) as entry_count
FROM bookings
WHERE branch_id = ? 
GROUP BY consignee_name, consignor_name, destination_city_id, destination_branch_id
HAVING COUNT(*) > 1
ORDER BY entry_count DESC LIMIT 60;";
    $stmt = $db->query($sql, [$_info->branch_id]);
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);;
    if (!$list) {
        $list = [];
    }

    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});
?>