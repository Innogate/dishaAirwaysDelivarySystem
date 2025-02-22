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
    }
    
?>