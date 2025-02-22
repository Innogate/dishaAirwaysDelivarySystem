<?php 
    class Database {
        private $pdo;
        public function __construct() {
            $config = require __DIR__ . '/../config/config.php';
            $dsn = "pgsql:host={$config['db']['host']};dbname={$config['db']['dbname']}";
            $this->pdo = new PDO($dsn, $config['db']['user'], $config['db']['password']);
        }
        public function query($sql, $params = []) {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        }
    }    
?>