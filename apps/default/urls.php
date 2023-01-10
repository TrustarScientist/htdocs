<?php
  include_once "views.php";
    $urlpatterns = [
        "/^$/" => $homePage,
        "/^tester$/" => $testerPage,
        "/^authcheck$/" => $authChecker,
        "/^404$/" => $fourOfour,
        "/^admin$/" => $adminMgr,
        "/^login$/" => $login,
        "/^auth$/" => $auth,
        "/^auth4login$/" => $authLogin,
        "/^auth4register$/" => $authRegister,
        "/^register$/" => $register,
        "/^auth4check$/" => $check,
    ];

?>