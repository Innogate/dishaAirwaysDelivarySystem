<?php

require_once __DIR__ . '/function.php';

class Database {
    public $pdo;

    public function __construct() {
        // Load configuration
        $config = require __DIR__ . '/../config/config.php';
        $dsn = "pgsql:host={$config['db']['host']};dbname={$config['db']['dbname']}";

        try {
            $this->pdo = new PDO($dsn, $config['db']['user'], $config['db']['password']);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die((new ApiResponse(500, "Database connection failed", $e->getMessage()))->toJson());
        }
    }

    // Execute a query with optional parameters
    public function query($sql, $params = []) {
        try {
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        } catch (PDOException $e) {
            $this->logDatabaseActivity($sql, $params, "Query failed: " . $e->getMessage()); // Log error
            die((new ApiResponse(500, "Query failed", $e->getMessage()))->toJson());
        }
    }

    // Log database activity to a file
    private function logDatabaseActivity($query, $params, $message = "Query executed") {
        $logFile = __DIR__ . '/db_activity.log';
        $logEntry = [
            'query' => $query,
            'params' => $params,
            'message' => $message,
            'timestamp' => date('Y-m-d H:i:s')
        ];
        file_put_contents($logFile, json_encode($logEntry) . PHP_EOL, FILE_APPEND);
    }

    // Fetch foreign key relationships
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

    // Generate dynamic SELECT query
    public function generateDynamicQuery($table, $fields) {
        // Validate input
        if (empty($table)) {
            throw new InvalidArgumentException("Invalid table name");
        }
        
        // If fields are empty, select all (*)
        if (empty($fields) || !is_array($fields)) {
            $fieldsString = "*";
        } else {
            // Escape field names to prevent SQL injection
            $escapedFields = array_map(function($field) {
                return str_replace("\"", "", $field); // Remove double quotes for PostgreSQL
            }, $fields);
            
            // Convert array to string
            $fieldsString = implode(", ", $escapedFields);
        }
        
        // Generate query
        $query = "SELECT $fieldsString FROM $table";
        
        return $query;
    }
    
    
    // Example Usage
    public function generateDynamicUpdate($table, $data, $condition) {
        // Validate input
        if (empty($table) || empty($data) || !is_array($data)) {
            throw new InvalidArgumentException("Invalid table name or data");
        }
        
        // Prepare set statements
        $setStatements = [];
        $values = [];
        foreach ($data as $column => $value) {
            $escapedColumn = str_replace("\"", "", $column); // Remove double quotes for PostgreSQL
            $setStatements[] = "$escapedColumn = ?";
            $values[] = $value;
        }
        
        $setString = implode(", ", $setStatements);
        
        // Generate query
        $query = "UPDATE $table SET $setString WHERE $condition";
        
        return [$query, $values];
    }
    // Transaction management
    public function rollback() {
        $this->pdo->rollBack();
    }

    public function commit() {
        $this->pdo->commit();
    }

    public function beginTransaction() {
        $this->pdo->beginTransaction();
    }

    // Generate database activity report
    public function generateDbReport() {
        $logFile = __DIR__ . '/db_activity.log';
        $logs = file($logFile, FILE_IGNORE_NEW_LINES);
        $activities = array_map('json_decode', $logs);

        echo "Database Activity Report\n";
        foreach ($activities as $activity) {
            echo "{$activity->timestamp} - {$activity->message}: {$activity->query}\n";
        }
    }

    public function modifySelectQueryWithForeignKeys($sql) {
        // Extract the table name from the query
        preg_match('/FROM\s+(\w+)/i', $sql, $matches);
        if (!isset($matches[1])) {
            return $sql; // Return original query if no table is found
        }
    
        $table = $matches[1];
        $foreignKeys = $this->getForeignKeys();
    
        // If the table has foreign keys, modify the query
        if (isset($foreignKeys[$table])) {
            $joins = [];
            $selectFields = [];
    
            // Extract selected fields
            preg_match('/SELECT\s+(.+?)\s+FROM/i', $sql, $fieldMatches);
            $selectedFields = isset($fieldMatches[1]) ? explode(',', $fieldMatches[1]) : ['*'];
            $selectedFields = array_map('trim', $selectedFields);
    
            foreach ($selectedFields as $key => $field) {
                // If selecting all fields, replace with explicit field list
                if ($field == '*') {
                    $stmt = $this->pdo->query("SELECT column_name FROM information_schema.columns WHERE table_name = '$table'");
                    $columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
                    $selectedFields = array_merge($selectedFields, $columns);
                    unset($selectedFields[$key]);
                    continue;
                }
            }
    
            // Modify the query to join foreign key tables
            foreach ($foreignKeys[$table] as $foreignTable => $joinCondition) {
                $joins[] = "LEFT JOIN $foreignTable ON $joinCondition";
    
                // Extract the foreign key column name
                preg_match('/\.(\w+) = /', $joinCondition, $fkMatches);
                if (isset($fkMatches[1])) {
                    $foreignColumn = $fkMatches[1];
    
                    // Replace the foreign key column with the related table’s data
                    if (in_array("$table.$foreignColumn", $selectedFields) || in_array($foreignColumn, $selectedFields)) {
                        $selectedFields[] = "$foreignTable.*"; // Select all columns from the foreign table
                        unset($selectedFields[array_search("$table.$foreignColumn", $selectedFields)]);
                    }
                }
            }
    
            // Rebuild the query
            $newFields = implode(", ", array_unique($selectedFields));
            $newJoins = implode(" ", $joins);
            $sql = preg_replace('/SELECT\s+.+?\s+FROM/i', "SELECT $newFields FROM", $sql);
            $sql .= " " . $newJoins;
        }
    
        return $sql;
    }
    
}
