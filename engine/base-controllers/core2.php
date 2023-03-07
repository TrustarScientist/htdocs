<?php
     // id token type checker
     function identifyer($data){
        $result = null;
        if(filter_var($data, FILTER_VALIDATE_EMAIL)){
            $result =  "email" ;
        }
       elseif(filter_var($data, FILTER_VALIDATE_INT)){
            $result = "number";
       }
        else{
            $result = "username";
        }
        // anyway...return the data
        return $result;
        
    }
    function personalizedPost($userId, $starting="0", $amount="7"){
        
        // scan through the current user's memberships
        $nicheObjects = xDb::find("niche_membership", "*", "where member = $userId");
        // load posts based on the current user's niches
        
        if(!empty($nicheObjects)){
            // firstly, let's build the sql code
            $query = "where ";
            foreach ($nicheObjects as $nObj) {
                # code...
                $nid = $nObj->niche;
                $query .= "category = $nid OR "; 
            }
            $query = substr($query, 0, (strlen($query)-3));
            $nPosts = xDb::find("post", "*", $query, "", " order by date_updated desc LIMIT $starting, $amount");
            // aggregate related data
            $personalizedPosts = array();
            $personalizedPost = array();
            $pos = 0;
            if(!empty($nPosts)){
                foreach ($nPosts as $nPost) {
                    # code...
                    $personalizedPost["postid"] = $nPost->id;
                    $personalizedPost["poster"] = array();
                    $personalizedPost["niche"] = array();
                    $personalizedPost["title"] = $nPost->title;
                    $personalizedPost["content"] = $nPost->content;
                    $personalizedPost["date"] = date("Y-M-d h:i:s",strtotime($nPost->date_updated));
                    $personalizedPost["slug"] = $nPost->slug;
                    $personalizedPost["views"] = $nPost->views;
                    $personalizedPost["thumbnail"] = "";
                    $personalizedPost["followings"] = 0;
                    $personalizedPost["comment_count"] = 0;
                    $personalizedPost["current_user_has_followed"] = 0;
                    $personalizedPost["current_user_is_post_niche_member"] = 0;
                    $personalizedPost["current_user_is_liking_poster"] = 0;
                    $personalizedPost["poster_blocked"] = false;
                    if(!empty(xDb::find("user_blacklist", "*", "WHERE blocker = $userId AND blocked = $nPost->poster"))){
                        $personalizedPost["poster_blocked"] = true;
                    }
                    $userObject = xDb::get("user", "id", $nPost->poster, "id, username, photo");
                    if(!empty($userObject)){
                        $personalizedPost["poster"] = $userObject;
                    }
                    $nicheObject = xDb::get("niche", "id", $nPost->category, "id, alias");
                    if(!empty($nicheObject)){
                        $personalizedPost["niche"] = $nicheObject;
                        // check current user's membership state in the niche the post is filed in
                        $membershipState = xDb::find("niche_membership", "*", "WHERE member = $userId AND niche = $nPost->category");
                        if(!empty($membershipState)){
                            $personalizedPost["current_user_is_post_niche_member"] = 1;
                        }
                    }
                    // photos
                    $thumbnail = xDb::get("post_image", "post", $nPost->id);
                    if(!empty($thumbnail)){
                        $personalizedPost["thumbnail"] = $thumbnail->path;
                    }
                    // comments count
                    $commentCount = xDb::getCount("post_comment", "*", "post", $nPost->id);
                    $personalizedPost["comment_count"] = $commentCount;
                    // post followings
                    $following_count = xDb::getCount("post_followership", "*", "post", $nPost->id);
                    if(!empty($following_count)){
                        $personalizedPost["followings"] = $following_count;
                    }
                    // is the current user already following this post?
                    $fState = xDb::find("post_followership", "*", "where follower = $userId AND post = $nPost->id");
                    if(!empty($fState)){
                        $personalizedPost["current_user_has_followed"] = 1;
                    }
                    
                    // add to personalized posts array
                    $personalizedPosts[$pos] = $personalizedPost;
                    $pos += 1;
                }
            }
            
            // return response
            echo json_encode($personalizedPosts);
        }
        else{
            //just return latest posts
            $posts = array();
            $index = 0;
            $container = array();
            $latestPosts = xDb::find("post", "*", "", "", "LIMIT $starting, $amount");
            if(!empty($latestPosts)){
                foreach ($latestPosts as $post) {
                    # code...
                    $container["postid"] = $post->id;
                    $container["poster"] = array();
                    $container["niche"] = array();
                    $container["title"] = $post->title;
                    $container["content"] = $post->content;
                    $container["date"] = $post->date("Y-M-d h:i:s",strtotime($post->date_updated));
                    $container["slug"] = $post->slug;
                    $container["views"] = $post->views;
                    $container["thumbnail"] = "";
                    $container["followings"] = 0;
                    $container["comment_count"] = 0;
                    $container["current_user_has_followed"] = 0;
                    $container["current_user_is_post_niche_member"] = 0;
                    $container["current_user_is_liking_poster"] = 0;
                    $container["poster_blocked"] = false;
                    if(!empty(xDb::find("user_blacklist", "*", "WHERE blocker = $userId AND blocked = $post->poster"))){
                        $container["poster_blocked"] = true;
                    }
                    $userObject = xDb::get("user", "id", $post->poster, "id, username, photo");
                    if(!empty($userObject)){
                        $container["poster"] = $userObject;
                    }
                    $nicheObject = xDb::get("niche", "id", $post->category, "id, alias");
                    if(!empty($nicheObject)){
                        $container["niche"] = $nicheObject;
                        // check current user's membership state in the niche the post is filed in
                        $membershipState = xDb::find("niche_membership", "*", "WHERE member = $userId AND niche = $post->category");
                        if(!empty($membershipState)){
                            $container["current_user_is_post_niche_member"] = 1;
                        }
                    }
                    // photos
                    $thumbnail = xDb::get("post_image", "post", $post->id);
                    if(!empty($thumbnail)){
                        $container["thumbnail"] = $thumbnail->path;
                    }
                    // comments count
                    $commentCount = xDb::getCount("post_comment", "*", "post", $post->id);
                    $container["comment_count"] = $commentCount;
                    // post followings
                    $following_count = xDb::getCount("post_followership", "*", "post", $post->id);
                    if(!empty($following_count)){
                        $container["followings"] = $following_count;
                    }
                    // is the current user already following this post?
                    $fState = xDb::find("post_followership", "*", "where follower = $userId AND post = $post->id");
                    if(!empty($fState)){
                        $container["current_user_has_followed"] = 1;
                    }
                    // add to personalized posts array
                    $posts[$index] = $container;
                    $index += 1;
                }
            }
            echo json_encode($posts);
        }
        
    }
    function comments($request){
        $postId = $_SESSION["post_id"];
        $starting = $request->POST["starting"];
        $amount = $request->POST["amount"];
        $comments = xDb::find("post_comment", "*", "where post = $postId", "", "LIMIT $starting, $amount");
        // replies
        if(!empty($comments)){
            foreach ($comments as $comment) {
                #commenter details
                $commenter = xDb::get("user", "id", $comment->commenter, "id, username, photo");
                $comment->commenter = $commenter;
                $comment->date_updated = date("Y-M-d",strtotime($comment->date_updated));
                # reply counts
                $replies = xDb::getCount("post_comment_reply", "*", "comment", $comment->id);
                $comment->replies = $replies;
            }
        }
        echo json_encode($comments);

    }


?>