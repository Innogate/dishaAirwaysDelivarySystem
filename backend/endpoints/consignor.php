<?php

require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$router->add("POST", "/consignor/new", function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission(1, $_info->user_id, "w");

    $data = json_decode(file_get_contents("php://input"), true);
    $require_data = ["consignor_name", "consignor_mobile"];
    $handler->validateInput($data, $require_data);

    $db = new Database();

    try {
        $stmt = $db->query("INSERT INTO consignor (consignor_name, consignor_mobile) VALUES (?,?) RETURNING id", [
            $data["consignor_name"],
            $data["consignor_mobile"]
        ]);

        $consignor_id = $stmt->fetchColumn();
        if (!$consignor_id) {
            throw new Exception("Consignor Creation Error");
        }

        (new ApiResponse(200, "Consignor created successfully", ["consignor_id" => $consignor_id], 200))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

$router->add("GET", "/consignor/list", function () {
    $jwt = new JwtHandler();
    $_info = $jwt->validate();

    $db = new Database();

    try {
        $stmt = $db->query("SELECT * FROM consignor");
        $consignors = $stmt->fetchAll(PDO::FETCH_ASSOC);

        (new ApiResponse(200, "Consignor List", $consignors, 200))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

$router->add("POST", "/consignor/byMobile", function (): void {
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $handler->validatePermission(1, $_info->user_id, "r");

    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["mobile"]);
    $mobile = $data["mobile"];
    $db = new Database();

    try {
        $stmt = $db->query("SELECT * FROM consignor WHERE consignor_mobile = ?", [$mobile]);
        $consignor = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$consignor) {
            throw new Exception("Consignor not found");
        }

        (new ApiResponse(200, "Consignor Details", $consignor, 200))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

?>