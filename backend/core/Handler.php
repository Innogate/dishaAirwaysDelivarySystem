<?php
    require_once __DIR__ . '/Database.php';
    class Handler {
        public static function validatePermission($pageId, $user_id=0, $permissionCheck="r") {
            $db = new Database();
            $stmt = $db->query("SELECT permission_code FROM permissions WHERE user_id = ? AND page_id = ?", [$user_id, $pageId]);
            $permission = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$permission || !isset($permission['permission_code'])) {
                $response = new ApiResponse(401,"Unauthorized access", "", 300);
                $response->toJson();
            }
            if ($permission['permission_code'] == "11111") {
                return True;
            }

            $permissionCodeExistArray = str_split($permission['permission_code']?? "");
            switch ($permissionCheck) {
                case 'r':
                    if ($permissionCodeExistArray[0] == "1") {
                        return true;
                    }
                    break;
                case 'w':
                    if ($permissionCodeExistArray[1] == "1") {
                        return true;
                    }
                    break;
                case 'u':
                    if ($permissionCodeExistArray[2] == "1") {
                        return true;
                    }
                    break;
                case 'd':
                    if ($permissionCodeExistArray[3] == "1") {
                        return true;
                    }
                    break;
                default:
                    $response = new ApiResponse(401,"Unauthorized access", "", 300);
                    $response->toJson();
                    break;
            }
        }
    }
?>