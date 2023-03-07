<?php
  include_once "views.php";
    $urlpatterns = [
        "/^following$/" => $postFollowing,
        "/^comments$/" => $postComments,
        "/^comment\/replies$/" => $commentReplies,
        "/^newsfeed$/" => $newsfeed,
        "/^create$/" => $editor,
        "/^trending$/" => $latest,
        "/^(\d+)\/([@*\w.+\[\]&()^:$?=%-]*)$/" => $postDetailsPage,
        "/^details$/" => $postDetails, 
        
    ];

?>