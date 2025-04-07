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

    // Fetch user
    $stmt = $db->query("SELECT user_id, password FROM users WHERE mobile = ?", [ $data['id'] ]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        (new ApiResponse(401, "User ID not matched", 201))->toJson();
        return;
    }

    // Password match (you should ideally use password_hash() and password_verify())
    if ($data['passwd'] !== $user['password']) {
        (new ApiResponse(401, "Password not matched", 202))->toJson();
        return;
    }

    // Get branch_id from representatives or branch_user
    $stmt = $db->query("SELECT branch_id FROM representatives WHERE user_id = ?", [ $user['user_id'] ]);
    $branch = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$branch) {
        $stmt = $db->query("SELECT branch_id FROM branch_user WHERE user_id = ?", [ $user['user_id'] ]);
        $branch = $stmt->fetch(PDO::FETCH_ASSOC);
    }

    $branch_id = $branch['branch_id'] ?? null;

    // Generate and return token
    $token = $jwt->generateToken([
        "user_id" => $user['user_id'],
        "branch_id" => $branch_id
    ]);

    (new ApiResponse(200, "Success", [
        "token" => $token,
        "user_id" => $user['user_id'],
    ]))->toJson();
});
?>
