<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    
    global $router;
    $router->add('POST', '/login', function () {
        $db = new Database();
        $jwt = new JwtHandler();
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $db->query("SELECT * FROM users WHERE mobile = ?", [ $data['id']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$user) {
            $response = new ApiResponse(401, "User ID not matched", 201);
            $response->toJson();
            return;
        }
        // password_verify
        if ($data['passwd'] == $user['password']) {
            $response = new ApiResponse(200, "Success", [
                "token" => $jwt->generateToken(["user_id" => $user['id']]),
                "user_id" => $user['id']]);
            $response->toJson();
            return;
        } else {
            $response = new ApiResponse(401, "Password not matched", 202);
            $response->toJson();
            return;
        }
    });    
?>