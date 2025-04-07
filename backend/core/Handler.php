<?php
require_once __DIR__ . '/Database.php';

class Handler {
    public static function validatePermission($pageId, $user_id = 0, $permissionCheck = "r") {
        $db = new Database();
        $stmt = $db->query("SELECT permission_code FROM permissions WHERE user_id = ? AND page_id = ?", [$user_id, $pageId]);
        $permission = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$permission || !isset($permission['permission_code'])) {
            (new ApiResponse(401, "You don't have access to this page", $permission, 300))->toJson();
            exit;
        }

        // Grant full access if permission code is '11111'
        if ($permission['permission_code'] === "11111") {
            return true;
        }

        $code = str_split($permission['permission_code']);

        $permissionMap = [
            'r' => 0,
            'w' => 1,
            'u' => 2,
            'd' => 3
        ];

        if (!isset($permissionMap[$permissionCheck])) {
            (new ApiResponse(401, "Invalid permission check type", "", 300))->toJson();
            exit;
        }

        $index = $permissionMap[$permissionCheck];

        // Check permission value, '1' means ALLOWED
        if (isset($code[$index]) && $code[$index] === "1") {
            return false;
        }

        (new ApiResponse(401, "Unauthorized access. Please contact admin.", "", 300))->toJson();
        exit;
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
