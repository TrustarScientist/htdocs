<?php
  include_once "views.php";
    $urlpatterns = [
        "/^(post)\/([@*,\w.+&^$?=%-]*)$/" => $post_media,
        "/^niche$/" => $niche,
    ];

?>