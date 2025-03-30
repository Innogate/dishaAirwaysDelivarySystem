<?php
    use Firebase\JWT\JWT;
    use Firebase\JWT\Key;
    class JwtHandler {
        private $secret;
        public function __construct() {
            $config = require __DIR__ . '/../config/config.php';
            $this->secret = $config['jwt_secret'];
        }
        public function generateToken($payload) {
            return JWT::encode($payload, $this->secret, 'HS256');
        }
        public function verifyToken($token) {
            try {
                return JWT::decode($token, new Key($this->secret, 'HS256'));
            } catch (Exception $e) {
                return null;
            }
        }

        public function validate(){
            $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
            $token = str_replace('Bearer ', '', $authHeader);
            $_info = $this->verifyToken($token);
            if (!$token || !$_info) {
                $response = new ApiResponse(401, "Unauthorized access", "", error_code: 101);
                $response->toJson();
                exit;
            }
            return $_info;
        }
    }
    
?>