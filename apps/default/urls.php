<?php
  include_once "views.php";
    $urlpatterns = [
        "/^$/" => $homePage,
        "/^ct_search$/" => $contentTypeSearch,
        "/^search$/" => $searchEngine,
        "/^quest$/" => $questSearch,
       "/^404$/" => $fourZeroFour,
       "/^login$/" => $login,
       "/^logout$/" => $logout,
       "/^about$/" => $about,
       "/^register$/" => $register,
       "/^newsfeed$/" => $newsfeed,
       "/^wsinfo$/" => $wsInfo,
       
    ];

?>