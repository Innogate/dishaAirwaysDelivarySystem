<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    
    global $router;
    $router->add('POST', '/template', function () {
        $db = new Database();
        $jwt = new JwtHandler();
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $db->query("SELECT * FROM users WHERE email = ?", [$data['email']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($user && password_verify($data['password'], $user['password'])) {
            echo json_encode(["token" => $jwt->generateToken(["user_id" => $user['id']])]);
        } else {
            http_response_code(401);
            echo json_encode(["error" => "Invalid credentials"]);
        }
    });    
?>