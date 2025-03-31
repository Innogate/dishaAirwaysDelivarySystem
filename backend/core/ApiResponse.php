<?php 
    class ApiResponse {
        public $status;
        public $message;
        public $body;
        public $error_code;
    
        public function __construct($status, $message, $body = null, $error_code = 0) {
            http_response_code($status);
            $this->status = $status;
            $this->message = $message;
            $this->body = $body;
            $this->error_code =$error_code;
        }
    
        public function toJson() {
            echo json_encode($this);
            exit;
        }
    }
    
?>