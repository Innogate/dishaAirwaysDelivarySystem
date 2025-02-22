<?php
    class Router {
        private $routes = [];
        public function add($method, $path, $handler) {
            $this->routes[strtoupper($method)][$path] = $handler;
        }
        public function resolve($uri, $method) {
            $method = strtoupper($method);
            if (isset($this->routes[$method][$uri])) {
                call_user_func($this->routes[$method][$uri]);
            } else {
                http_response_code(404);
                echo json_encode(["error" => "Not Found"]);
            }
        }
    }
?>