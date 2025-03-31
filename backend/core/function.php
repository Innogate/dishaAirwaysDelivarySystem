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

function splitString($inputString) {
    // Split the input string into the character part and numeric part
    $prefix = preg_replace('/[0-9]/', '', $inputString); // Extract the letters (e.g., KBS)
    $numberPart = preg_replace('/\D/', '', $inputString); // Extract the numeric part (e.g., 0001)

    // Ensure both parts are extracted correctly
    if (empty($prefix) || !is_numeric($numberPart)) {
        return "Invalid input format.";
    }

    // Return the character and numeric parts
    return [
        'prefix' => $prefix,
        'number' => $numberPart
    ];
}

?>