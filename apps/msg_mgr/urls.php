<?php
    include_once "views.php";
    $urlpatterns = [
        "/^inbox$/" => $inbox,
        "/^inbox\/latest$/" => $getLatestMessages,
        // "/^conversation$/" => $conversation,
        "/^send$/" => $addMessage,
        // "/^friendtochat$/"=>  $returnfriends,
        // "/^getChats$/"=>$getChats,
        // "/^sendchat$/"=> $insertChat,
        // "/^checkchat$/"=> $constantChecking,
        // "/^getFriends$/"=>$getFriends,
        // "/^sendRequest$/"=>$sendRequest,
        // "/^getFriendRequest$/"=>$getFriendRequest,
        // "/^friendRequestResponse$/"=>$friendRequestResponse
    ];
?>