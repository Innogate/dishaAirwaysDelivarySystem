<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    
    global $router;
    $router->add('POST', '/login', function () {
        $db = new Database();
        $jwt = new JwtHandler();
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $db->query("SELECT * FROM users WHERE id = ?", [$data['id']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        // password_verify
        if ($user && $data['passwd'] == $user['password']) {
            $response = new ApiResponse(200, "Success", ["token" => $jwt->generateToken(["user_id" => $user['id']])]);
            $response->toJson();
        } else {
            $response = new ApiResponse(401, "Invalid credentials");
            $response->toJson();
        }
    });    
?>