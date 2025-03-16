<?php
    require_once __DIR__ . '/Database.php';
    class Handler {
        public static function validatePermission($pageId, $user_id=0, $permissionCheck="r") {
            $db = new Database();
            $stmt = $db->query("SELECT permission_code FROM permissions WHERE user_id = ? AND page_id = ?", [$user_id, $pageId]);
            $permission = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$permission || !isset($permission['permission_code'])) {
                $response = new ApiResponse(401,"Don't have access this page", "", 300);
                $response->toJson();
            }
            if ($permission['permission_code'] == "11111") {
                return true;
            }

            $permissionCodeExistArray = str_split($permission['permission_code']?? "");
            switch ($permissionCheck) {
                case 'r':
                    if ($permissionCodeExistArray[0] == "1") {
                        return false;
                    }
                    $response = new ApiResponse(401,"Unauthorized access not permit access this page contact admin for more info.", "", 300);
                    $response->toJson();
                    break;
                case 'w':
                    if ($permissionCodeExistArray[1] == "1") {
                        return false;
                    }
                    $response = new ApiResponse(401,"Unauthorized access not permit access this page contact admin for more info.", "", 300);
                    $response->toJson();
                    break;
                case 'u':
                    if ($permissionCodeExistArray[2] == "1") {
                        return false;
                    }
                    $response = new ApiResponse(401,"Unauthorized access not permit access this page contact admin for more info.", "", 300);
                    $response->toJson();
                    break;
                case 'd':
                    if ($permissionCodeExistArray[3] == "1") {
                        return false;
                    }
                    $response = new ApiResponse(401,"Unauthorized access not permit access this page contact admin for more info.", "", 300);
                    $response->toJson();
                    break;
                default:
                    $response = new ApiResponse(401,"Unauthorized access not permit access this page contact admin for more info.", "", 300);
                    $response->toJson();
                    break;
            }
        }

        public static function validateInput($data, $requiredFields) {
            if (!is_array($data) || array_keys($data) === range(0, count($data) - 1)) {
                (new ApiResponse(400, "Invalid input format. Expected an object."))->toJson();
                exit;
            }
            
            foreach ($requiredFields as $field) {
                if (!isset($data[$field])) {
                    (new ApiResponse(400, "Missing required field: $field"))->toJson();
                    exit;
                }
            }
        }
    }
?>