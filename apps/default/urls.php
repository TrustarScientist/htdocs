<?php
  include_once "views.php";
    $urlpatterns = [
        "/^$/" => $homePage,
        "/^search$/" => $searchEngine,
       "/^404$/" => $fourZeroFour,
       "/^login$/" => $login,
       "/^logout$/" => $logout,
       "/^about$/" => $about,
       "/^register$/" => $register,
       "/^newsfeed$/" => $newsfeed,
       "/^connections$/" => $connections,
    ];

?>