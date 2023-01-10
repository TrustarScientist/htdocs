<?php

    session_start();

    define("DB_NAME", "ssd");
    define("DB_HOST", "localhost");
    define("DB_USER", "root");
    define("DB_PASS", "");
    define("DB_ENGINE", "mysql");
    define("LOG_FILE", "log.txt");

    // installed apps[sub-project codes]
    $installedApps = [
        "practice" => "practice",
        "learn" =>"learn",
        "socialize" => "socialize",
        "payment" => "payment",
        "search" => "search",
      ];
?>