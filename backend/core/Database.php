<?php
require_once __DIR__ . '/function.php';

class Database {
    private $pdo;

    public function __construct() {
        $config = require __DIR__ . '/../config/config.php';
        $dsn = "pgsql:host={$config['db']['host']};dbname={$config['db']['dbname']}";

        try {
            $this->pdo = new PDO($dsn, $config['db']['user'], $config['db']['password']);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die((new ApiResponse(500, "Database connection failed", $e->getMessage()))->toJson());
        }
    }

    public function query($sql, $params = []) {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        } catch (PDOException $e) {
            die((new ApiResponse(500, "Query failed", $e->getMessage()))->toJson());
        }
    }

    private function getForeignKeys() {
        $stmt = $this->pdo->query(
            "SELECT 
                kcu.table_name, kcu.column_name, 
                ccu.table_name AS foreign_table_name, ccu.column_name AS foreign_column_name 
             FROM information_schema.key_column_usage AS kcu
             JOIN information_schema.constraint_column_usage AS ccu
             ON kcu.constraint_name = ccu.constraint_name
             WHERE kcu.table_schema = 'public';"
        );
        
        $foreignKeys = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $foreignKeys[$row['table_name']][$row['foreign_table_name']] = 
                "{$row['table_name']}.{$row['column_name']} = {$row['foreign_table_name']}.{$row['foreign_column_name']}";
        }
        return $foreignKeys;
    }

    public function generateDynamicQuery(array $columns, ?string $joinBy = null) {
        $tables = [];
        $joins = [];
        $selectedColumns = [];

        foreach ($columns as $col) {
            if (strpos($col, ".*") !== false) {
                $table = str_replace(".*", "", $col);
                $selectedColumns[] = "$table.*";
            } else {
                $parts = explode(".", $col);
                if (count($parts) === 2) {
                    list($table, $column) = $parts;
                    $selectedColumns[] = "$table.$column";
                } else {
                    die((new ApiResponse(400, "Invalid column format: $col"))->toJson());
                }
            }
            if (!in_array($table, $tables)) {
                $tables[] = $table;
            }
        }

        if (!$joinBy && count($tables) > 1) { // Ensure multiple tables exist before attempting joins
            $foreignKeys = $this->getForeignKeys();
            foreach ($tables as $table) {
                if (isset($foreignKeys[$table])) {
                    foreach ($foreignKeys[$table] as $relatedTable => $condition) {
                        if (in_array($relatedTable, $tables) && !in_array("JOIN $relatedTable ON $condition", $joins)) {
                            $joins[] = "JOIN $relatedTable ON $condition";
                        }
                    }
                }
            }
        }

        if ($joinBy) {
            foreach (explode(",", $joinBy) as $condition) {
                $condition = trim($condition);
                if (strpos($condition, "=") !== false) {
                    list($left, $right) = explode("=", $condition);
                    $leftTable = explode(".", trim($left))[0];
                    $rightTable = explode(".", trim($right))[0];

                    if (in_array($leftTable, $tables) && in_array($rightTable, $tables)) {
                        $joins[] = "JOIN $rightTable ON $condition";
                    }
                }
            }
        }

        if (empty($tables)) {
            die((new ApiResponse(400, "No valid tables detected"))->toJson());
        }

        $fromTable = $tables[0];
        $query = "SELECT " . implode(", ", $selectedColumns) . " FROM $fromTable";
        if (!empty($joins)) {
            $query .= " " . implode(" ", $joins);
        }

        return $query;
    }

    public function generateDynamicUpdate(array $updates, array $conditions) {
        if (empty($updates)) {
            die((new ApiResponse(400, "No update data provided"))->toJson());
        }
    
        $tables = [];
        $updateClauses = [];
        $whereClauses = [];
        $params = [];
    
        // Process updates
        foreach ($updates as $column => $value) {
            if (!str_contains($column, ".")) {
                die((new ApiResponse(400, "Invalid column format: $column"))->toJson());
            }
    
            list($table, $col) = explode(".", $column, 2);
            $tables[$table] = $table;
            $updateClauses[$table][] = "$col = ?";
            $params[] = $value;
        }
    
        // Process conditions
        foreach ($conditions as $column => $value) {
            if (!str_contains($column, ".")) {
                die((new ApiResponse(400, "Invalid condition format: $column"))->toJson());
            }
    
            list($table, $col) = explode(".", $column, 2);
            $whereClauses[$table][] = "$col = ?";
            $params[] = $value;
        }
    
        // Build SQL Queries
        $queries = [];
        foreach ($updateClauses as $table => $updates) {
            $updateQuery = "UPDATE $table SET " . implode(", ", $updates);
            if (!empty($whereClauses[$table])) {
                $updateQuery .= " WHERE " . implode(" AND ", $whereClauses[$table]);
            }
            $queries[] = $updateQuery;
        }
    
        // Combine queries using transactions for consistency
        $finalQuery = "" . implode("; ", $queries) . "";
    
        return ['query' => $finalQuery, 'params' => $params];
    }
    

    public function rollback() {
        $this->pdo->rollBack();
    }

    public function commit() {
        $this->pdo->commit();
    }

    public function beginTransaction(){
        $this->pdo->beginTransaction();
    }
    
}