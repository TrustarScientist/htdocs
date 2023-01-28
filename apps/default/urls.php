<?php
  include_once "views.php";
    $urlpatterns = [
        "/^$/" => $homePage,
       "/^404$/" => $fourZeroFour,
       "/^login$/" => $login,
    ];

?>