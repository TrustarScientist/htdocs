<?php
  include_once "views.php";
    $urlpatterns = [
      "/^toprank$/" => $topRank,
      "/^join-or-leave$/" => $joinOrLeave,
      "/^posts$/" => $nichePosts,
      "/^(@\w+)$/" => $niche,
        
    ];

?>