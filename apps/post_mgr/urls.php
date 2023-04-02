<?php
  include_once "views.php";
    $urlpatterns = [
        "/^following$/" => $postFollowing,
        "/^comments$/" => $postComments,
        "/^comment\/replies$/" => $commentReplies,
        "/^newsfeed$/" => $newsfeed,
        "/^edit$/" => $editor,
        "/^trending$/" => $latest,
        "/^editor\/image\/upload/" => $imageUploader,
        "/^editor\/create-post$/" => $createPost,
        "/^editor\/update-post$/" => $updatePost,
        "/^editor\/delete-post$/" => $deletePost,
        "/^editor\/post2edit$/" => $post2Edit,
        "/^editor\/posts$/" => $cUserPosts,
        "/^(\d+)\/([@*\w.+\[\]&()^:$?=%-]*)$/" => $postDetailsPage,
        "/^details$/" => $postDetails, 
        
    ];

?>