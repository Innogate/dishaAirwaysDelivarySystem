<?php

require_once __DIR__ . '/ApiResponse.php'; // Include any necessary response handling classes

class Router {
    private $routes = []; // Stores all defined routes

    // Add a route to the router
    public function add($method, $path, $handler) {
        $method = strtoupper($method);
        $this->routes[$method][$path] = $handler;
    }

    // Resolve a request and handle the response
    public function resolve($uri, $method) {
        $method = strtoupper($method);

        // Strip the /control prefix if app is inside that folder
        $uri = preg_replace('#^/control#', '', $uri);

        $logData = [
            'uri' => $uri,
            'method' => $method,
            'timestamp' => date('Y-m-d H:i:s')
        ];

        $this->logActivity($logData); // Log the request activity

        // Check if the requested route exists
        if (isset($this->routes[$method][$uri])) {
            call_user_func($this->routes[$method][$uri]);
        } else {
            http_response_code(404);
            echo json_encode(["error" => "INVALID ENDPOINT"]);
        }
    }

    // Log server activity to a file
    private function logActivity($data) {
        $logFile = __DIR__ . '/server_activity.log';
        file_put_contents($logFile, json_encode($data) . PHP_EOL, FILE_APPEND);
    }

    // Generate a report from the logged activities
    public function generateServerActivityReport() {
        $logFile = __DIR__ . '/server_activity.log';

        if (!file_exists($logFile)) {
            echo "No activity logs found.\n";
            return;
        }

        $logs = file($logFile, FILE_IGNORE_NEW_LINES);
        $activities = array_map('json_decode', $logs);

        echo "Server Activity Report\n";
        foreach ($activities as $activity) {
            echo "{$activity->timestamp} - {$activity->method} {$activity->uri}\n";
        }
    }
}

// Example usage:
// $router = new Router();
// $router->add('GET', '/home', function() { echo "Welcome to the homepage!"; });
// $router->resolve('/home', 'GET');
// $router->generateServerActivityReport();

?>
