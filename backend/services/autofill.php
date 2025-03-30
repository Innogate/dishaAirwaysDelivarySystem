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
    $search = $data["search"]."%";
   
    
    $sql = "SELECT DISTINCT ON (b.consignee_name, b.consignee_mobile, b.consignor_name, b.consignor_mobile) 
    b.consignee_name, 
    b.consignee_mobile, 
    b.destination_city_id, 
    b.consignor_name, 
    b.consignor_mobile, 
    b.destination_branch_id
FROM public.bookings b
WHERE 
    b.consignee_name ILIKE ? 
    OR CAST(b.consignee_mobile AS TEXT) ILIKE ? 
    OR b.consignor_name ILIKE ? 
    OR CAST(b.consignor_mobile AS TEXT) ILIKE ?
LIMIT 30";
    
    $stmt = $db->query($sql, [$search, $search, $search, $search]); 
    $list = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (!$list) {
        $list = [];
    }
    
    $response = new ApiResponse(200, "Success", $list);
    $response->toJson();
});
?>