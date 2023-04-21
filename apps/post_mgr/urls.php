<?php
  include_once "views.php";
    $urlpatterns = [
        "/^following$/" => $postFollowing,
        "/^comments$/" => $postComments,
        "/^comment\/add$/" => $commentAdd,
        "/^comment\/replies$/" => $commentReplies,
        "/^comment\/replies\/add$/" => $replyAdd,
        "/^newsfeed$/" => $newsfeed,
        "/^edit$/" => $editor,
        "/^trending$/" => $latest,
        "/^editor\/image\/upload/" => $imageUploader,
        "/^editor\/create-post$/" => $createPost,
        "/^editor\/update-post$/" => $updatePost,
        "/^editor\/delete-post$/" => $deletePost,
        "/^editor\/post2edit$/" => $post2Edit,
        "/^editor\/posts$/" => $cUserPosts,
        "/^editor\/posts\/search$/" => $cUserPostsSearch,
        "/^(\d+)\/([@*\w.+\[\]&()^:$?=%-]*)$/" => $postDetailsPage,
        "/^details$/" => $postDetails,
        "/^pvt\/details$/" => $pvtPostDetails,
        
    ];

?>