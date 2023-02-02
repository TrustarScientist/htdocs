<?php
  include_once "views.php";
    $urlpatterns = [
        "/^posts$/" => $userPosts,
        "/^([@*,\w.+&^$?=%-]*)$/" => $profile,
    ];

?>