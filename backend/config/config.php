<?php
    return [
        'db' => [
            'host' => getenv('DB_HOST'),
            'dbname' => getenv('DB_NAME'),
            'user' => getenv('DB_USER'),
            'password' => getenv('DB_PASSWORD')
        ],
        'jwt_secret' => getenv('JWT_SECRET')
    ];
?>