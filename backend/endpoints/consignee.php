<?php
require_once __DIR__ . '/../core/JwtHandler.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Handler.php';

global $router;
global $pageID;

$router->add("POST", "/consignee/new", function () {
    $jwt = new JwtHandler();
    $handler = new Handler();
    $_info = $jwt->validate();
    $handler->validatePermission(1, $_info->user_id, "w"); // Check user permission

    $data = json_decode(file_get_contents("php://input"), true);
    $require_data = ["consignee_name", "consignee_mobile"];
    $handler->validateInput($data, $require_data);

    $db = new Database();

    try {
        $stmt = $db->query("INSERT INTO consignee (consignee_name, consignee_mobile) VALUES (?,?) RETURNING id", [
            $data["consignee_name"],
            $data["consignee_mobile"]
        ]);

        $consignee_id = $stmt->fetchColumn();
        if (!$consignee_id) {
            throw new Exception("Consignee Creation Error");
        }

        (new ApiResponse(200, "Consignee created successfully", ["consignee_id" => $consignee_id], 200))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

$router->add("GET", "/consignee/list", function () {
    $jwt = new JwtHandler();
    $_info = $jwt->validate();

    $db = new Database();

    try {
        $stmt = $db->query("SELECT * FROM consignee");
        $consignees = $stmt->fetchAll(PDO::FETCH_ASSOC);

        (new ApiResponse(200, "Consignee List", $consignees, 200))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

$router->add("POST", "/consignee/byMobile", function () {
    $jwt = new JwtHandler();
    $_info = $jwt->validate();
    $handler = new Handler();
    $handler->validatePermission(1, $_info->user_id, "w"); // Check user permission
    $data = json_decode(file_get_contents("php://input"), true);
    $handler->validateInput($data, ["mobile"]);
    $db = new Database();

    try {
        $stmt = $db->query("SELECT * FROM consignee WHERE consignee_mobile = ?", [$data["mobile"]]);
        $consignee = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$consignee) {
            throw new Exception("Consignee not found");
        }

        (new ApiResponse(200, "Consignee Details", $consignee, 200))->toJson();
    } catch (Exception $e) {
        (new ApiResponse(500, $e->getMessage(), "", 500))->toJson();
    }
});

?>