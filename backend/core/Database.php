<<<<<<< HEAD
<?php
=======
<?php 
>>>>>>> ba880b0 (states and citis master)
class Database {
    private $pdo;
    
    public function __construct() {
        $config = require __DIR__ . '/../config/config.php';
        $dsn = "pgsql:host={$config['db']['host']};dbname={$config['db']['dbname']}";
<<<<<<< HEAD
        
        try {
            $this->pdo = new PDO($dsn, $config['db']['user'], $config['db']['password']);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Database connection failed: " . $e->getMessage());
        }
    }

    public function query($sql, $params = []) {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        } catch (PDOException $e) {
            die("Query failed: " . $e->getMessage());
        }
    }

    // PostgreSQL does not support lastInsertId() without a sequence name
    public function lastInsertId($sequenceName = null) {
        if ($sequenceName) {
            return $this->pdo->query("SELECT currval('$sequenceName')")->fetchColumn();
        }
        return null;
    }

    public function beginTransaction() {
        return $this->pdo->beginTransaction();
    }

    public function commit() {
        return $this->pdo->commit();
    }

    public function rollBack() {
        return $this->pdo->rollBack();
=======
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
>>>>>>> ba880b0 (states and citis master)
    }
}
?>
