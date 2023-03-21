<?php
  include_once "views.php";
    $urlpatterns = [
      "/^niches$/" => $acctNiches,
      "/^friend-requests$/" => $friendRequests,
      "/^friend-request\/send$/" => $sendFriendRequest,
      "/^friendship\/stop$/" => $friendshipStop,
      "/^connections$/" => $connections,
      "/^connection\/accept$/" => $acceptance,
      "/^connection\/rejection$/" => $rejection,
      "/^blacklist$/" => $blacklist,
      "/^likeness$/" => $likeness,
      "/^profile\/self$/" => $selfInfo,
      "/^profile\/update$/" => $profileUpdate,
      "/^recommended-people$/" => $recommendedPeople4Self,
      "/^recommended-niches$/" => $recommendedNiches,
        "/^posts$/" => $userPosts,
        "/^people-networked-to$/" => $networkedPeople,
        "/^([@*,\w.+&^$?=%-]*)$/" => $profile,
    ];

?>