<?php
 function validate()  {
    $jwt = new JwtHandler();
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    $token = str_replace('Bearer ', '', $authHeader);
    $_info = $jwt->verifyToken($token);
    if (!$token || !$_info) {
        $response = new ApiResponse(401, "Unauthorized access", "", error_code: 101);
        $response->toJson();
        exit;
    }
 }
 function convertToDbFormat($dateString) {
    // Create a DateTime object from the given date string
    $date = DateTime::createFromFormat('d-m-Y', $dateString);

    // Check if the date was successfully created
    if ($date === false) {
        return "Invalid date format";
    }

    // Format the date into YYYY-MM-DD
    return $date->format('Y-m-d');
}
function splitAndIncrement($input) {
    preg_match('/^([A-Za-z]+)(\d+)$/', $input, $matches);
    if ($matches) {
        $word = $matches[1]; // Extract word part
        $number = $matches[2]; // Extract number part
        $newNumber = str_pad($number + 1, strlen($number), '0', STR_PAD_LEFT); // Increment and keep leading zeros
        return $word . $newNumber;
    }
    return null; // Return null if format is incorrect
}

?>