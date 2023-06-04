<?php
    include_once "views.php";
    $urlpatterns = [
        "/^inbox$/" => $inbox,
        "/^inbox\/latest$/" => $getLatestMessages,
        "/^conversation$/" => $conversation,
        "/^send$/" => $addMessage,
        
    ];
?>