<?php
  include_once "views.php";
    $urlpatterns = [
        "/^(post)\/([@*,\w.+&^$?=%-]*)$/" => $post_media,
        "/^(profile)\/([@*,\w.+&^$?=%-]*)$/" => $user_media,
        "/^niche$/" => $niche,
    ];

?>