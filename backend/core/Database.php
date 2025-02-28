<?php 
class Database {
    private $pdo;
    
    public function __construct() {
        $config = require __DIR__ . '/../config/config.php';
        $dsn = "pgsql:host={$config['db']['host']};dbname={$config['db']['dbname']}";
        $this->pdo = new PDO($dsn, $config['db']['user'], $config['db']['password']);
        $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    public function query($sql, $params = []) {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    // Method to get the last inserted ID for PostgreSQL
    public function lastInsertId($sequenceName = null) {
        return $this->pdo->lastInsertId($sequenceName);
    }
}
?>
