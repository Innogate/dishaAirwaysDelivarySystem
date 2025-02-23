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
            echo json_encode(["token" => $jwt->generateToken(["user_id" => $user['id']])]);
        } else {
            http_response_code(401);
            echo json_encode(["error" => "Invalid credentials"]);
        }
    });    
?>