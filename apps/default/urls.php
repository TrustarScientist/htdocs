<?php
  include_once "views.php";
    $urlpatterns = [
        "/^$/" => $homePage,
        "/^search$/" => $searchEngine,
       "/^404$/" => $fourZeroFour,
       "/^login$/" => $login,
    ];

?>