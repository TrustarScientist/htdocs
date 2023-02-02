<?php

    session_start();

    define("DB_NAME", "stemxdb");
    define("DB_HOST", "localhost");
    define("DB_USER", "root");
    define("DB_PASS", "");
    define("DB_ENGINE", "mysql");
    define("LOG_FILE", "log.txt");

    // installed apps[sub-project codes]
    $installedApps = [
        "post_mgr" => "post",
        "media_mgr" => "storage",
        "acct_mgr" => "user",
        "niche_mgr" => "niche",
        
      ];
?>