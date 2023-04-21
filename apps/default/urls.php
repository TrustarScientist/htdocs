<?php
  include_once "views.php";
    $urlpatterns = [
        "/^$/" => $homePage,
        "/^search$/" => $searchEngine,
        "/^quest$/" => $questSearch,
       "/^404$/" => $fourZeroFour,
       "/^login$/" => $login,
       "/^logout$/" => $logout,
       "/^about$/" => $about,
       "/^register$/" => $register,
       "/^newsfeed$/" => $newsfeed,
       
    ];

?>