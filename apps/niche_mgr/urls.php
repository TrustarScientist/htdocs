<?php
  include_once "views.php";
    $urlpatterns = [
      "/^members$/" => $nicheMembers,
      "/^toprank$/" => $topRank,
      "/^join-or-leave$/" => $joinOrLeave,
      "/^pvt\/posts$/" => $pvtNichePosts,
      "/^posts$/" => $nichePosts,
      "/^details$/" => $nicheInfo,
      "/^(@\w+)$/" => $niche,
        
    ];

?>