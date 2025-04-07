<?php

require_once __DIR__ . '/function.php';

class Database {
    public $pdo;

    public function __construct() {
        // Load configuration
        $config = require __DIR__ . '/../config/config.php';
        $dsn = "mysql:host={$config['db']['host']};dbname={$config['db']['dbname']};charset=utf8mb4";

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
            $this->logDatabaseActivity($sql, $params, "Query failed: " . $e->getMessage());
            die((new ApiResponse(500, "Query failed", $e->getMessage()))->toJson());
        }
    }

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

    private function getForeignKeys() {
        $stmt = $this->pdo->query("
            SELECT 
                TABLE_NAME, COLUMN_NAME, 
                REFERENCED_TABLE_NAME AS foreign_table_name, 
                REFERENCED_COLUMN_NAME AS foreign_column_name 
            FROM information_schema.KEY_COLUMN_USAGE 
            WHERE TABLE_SCHEMA = DATABASE() AND REFERENCED_TABLE_NAME IS NOT NULL;
        ");

        $foreignKeys = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $foreignKeys[$row['TABLE_NAME']][$row['foreign_table_name']] =
                "{$row['TABLE_NAME']}.{$row['COLUMN_NAME']} = {$row['foreign_table_name']}.{$row['foreign_column_name']}";
        }
        return $foreignKeys;
    }

    public function generateDynamicQuery($table, $fields) {
        if (empty($table)) {
            throw new InvalidArgumentException("Invalid table name");
        }

        $fieldsString = "*";
        if (!empty($fields) && is_array($fields)) {
            $escapedFields = array_map(function($field) {
                return str_replace("`", "", $field);
            }, $fields);
            $fieldsString = implode(", ", $escapedFields);
        }

        return "SELECT $fieldsString FROM $table";
    }

    public function generateDynamicUpdate($table, $data, $condition) {
        if (empty($table) || empty($data) || !is_array($data)) {
            throw new InvalidArgumentException("Invalid table name or data");
        }

        $setStatements = [];
        $values = [];
        foreach ($data as $column => $value) {
            $escapedColumn = str_replace("`", "", $column);
            $setStatements[] = "`$escapedColumn` = ?";
            $values[] = $value;
        }

        $setString = implode(", ", $setStatements);
        $query = "UPDATE `$table` SET $setString WHERE $condition";

        return [$query, $values];
    }

    public function rollback() {
        $this->pdo->rollBack();
    }

    public function commit() {
        $this->pdo->commit();
    }

    public function beginTransaction() {
        $this->pdo->beginTransaction();
    }

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
        preg_match('/FROM\s+(\w+)/i', $sql, $matches);
        if (!isset($matches[1])) {
            return $sql;
        }

        $table = $matches[1];
        $foreignKeys = $this->getForeignKeys();

        if (isset($foreignKeys[$table])) {
            $joins = [];
            $selectFields = [];

            preg_match('/SELECT\s+(.+?)\s+FROM/i', $sql, $fieldMatches);
            $selectedFields = isset($fieldMatches[1]) ? explode(',', $fieldMatches[1]) : ['*'];
            $selectedFields = array_map('trim', $selectedFields);

            foreach ($selectedFields as $key => $field) {
                if ($field === '*') {
                    $stmt = $this->pdo->query("SHOW COLUMNS FROM `$table`");
                    $columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
                    $selectedFields = array_merge($selectedFields, $columns);
                    unset($selectedFields[$key]);
                    continue;
                }
            }

            foreach ($foreignKeys[$table] as $foreignTable => $joinCondition) {
                $joins[] = "LEFT JOIN `$foreignTable` ON $joinCondition";

                preg_match('/\.(\w+) = /', $joinCondition, $fkMatches);
                if (isset($fkMatches[1])) {
                    $foreignColumn = $fkMatches[1];
                    if (in_array("$table.$foreignColumn", $selectedFields) || in_array($foreignColumn, $selectedFields)) {
                        $selectedFields[] = "$foreignTable.*";
                        unset($selectedFields[array_search("$table.$foreignColumn", $selectedFields)]);
                    }
                }
            }

            $newFields = implode(", ", array_unique($selectedFields));
            $newJoins = implode(" ", $joins);
            $sql = preg_replace('/SELECT\s+.+?\s+FROM/i', "SELECT $newFields FROM", $sql);
            $sql .= " " . $newJoins;
        }

        return $sql;
    }

    public function lastInsertId(){
        return $this->pdo->lastInsertId();
    }
}
