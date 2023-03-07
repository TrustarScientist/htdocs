<?php
  include_once "views.php";
    $urlpatterns = [
      "/^blacklist$/" => $blacklist,
      "/^likeness$/" => $likeness,
      "/^profile\/self$/" => $selfInfo,
      "/^recommended-people$/" => $recommendedPeople4Self,
        "/^posts$/" => $userPosts,
        "/^([@*,\w.+&^$?=%-]*)$/" => $profile,
    ];

?>