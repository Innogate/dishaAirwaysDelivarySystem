<?php 
    require_once __DIR__ . '/../core/JwtHandler.php';
    require_once __DIR__ . '/../core/Database.php';
    require_once __DIR__ . '/../core/function.php';
    require_once __DIR__ . '/../core/Handler.php';
    
    global $router;
    $router->add('POST', '/login', function () {
        $db = new Database();
        $jwt = new JwtHandler();
        $handler = new Handler();
        $data = json_decode(file_get_contents("php://input"), true);
        $required_fields = ["id", "passwd"];
        $handler->validateInput($data, $required_fields);

        $stmt = $db->query("SELECT user_id, password FROM users WHERE mobile = ?", [ $data['id']]);
        $user = $stmt->fetch(mode: PDO::FETCH_ASSOC);

        if (!$user) {
            $response = new ApiResponse(401, "User ID not matched", 201);
            $response->toJson();
            return;
        }
 
        if ($data['passwd'] == $user['password']) {
            $stmt = $db->query('SELECT branch_id FROM representatives WHERE user_id = ?', [ $user['user_id'] ]);
            $brach = $stmt->fetch(mode: PDO::FETCH_ASSOC);
            if ($brach) {
                $branch_id = $brach['branch_id'];
            } else {
                $branch_id = null;
            }
            $response = new ApiResponse(200, "Success", body: [
                "token" => $jwt->generateToken([
                    "user_id" => $user['user_id'],
                    "branch_id" => $branch_id
                ]),
                "user_id" => $user['user_id'],
            ]);
            $response->toJson();
            return;
        } else {
            $response = new ApiResponse(401, "Password not matched", 202);
            $response->toJson();
            return;
        }
    });    
?>