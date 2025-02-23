<?php 
    class ApiResponse {
        public $status;
        public $message;
        public $body;
    
        public function __construct($status, $message, $body = null) {
            $this->status = $status;
            $this->message = $message;
            $this->body = $body;
        }
    
        public function toJson() {
            echo json_encode($this);
        }
    }
    
?>