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
            /**
             *  check whether the current user is a member of any niche
             *  if it's a member, continue processing
             *  else join the current user to the default or overall 'mother' niche
             */
            if(empty(xDb::get("niche_membership", "member", $userId))){
                xDb::create("niche_membership", array(
                    "niche" => 7,
                    "member" => $userId,
                ));
            }
            // get some posts
            $randomPosts = xDb::find("post", "*", "WHERE visibility = 'pub'", "ORDER BY date_updated DESC", "LIMIT $starting, $amount");
            // final dataset to return to client
            $responseData2 = array();
            // aggregate data
            $post2 = array();
            $ct2 = 0;
            
            foreach($randomPosts as $data2) {
                $post2["poster_blocked"] = false;
                $blacklist = xDb::find("user_blacklist", "*", "WHERE blocked = $data2->poster AND blocker = $userId");
                if(!empty($blacklist)){
                    $post2["poster_blocked"] = true;
                }
                $post2["cuser_is_member"] = false;
                $membership = xDb::find("niche_membership", "*", "WHERE niche = $data2->category AND member = $userId");
                if(!empty($membership)){
                    $post2["cuser_is_member"] = true;
                }
                $post2["contenttype"] = (xDb::get("contenttype", "id", $data2->content_type))->name;
                $post2["postid"] = $data2->id;
                $post2["title"] = $data2->title;
                $post2["slug"] = $data2->slug;
                $post2["content"] = $data2->content;
                $post2["updated"] = date("Y-M-d",strtotime($data2->date_updated));
                $post2["views"] = $data2->views;
                // user who created
                $post2["user"] = "";
                $post2["own"] = 0;
                if($userId == $data2->poster){
                    $post2["own"] = 1;
                }
                $userObj = "";
                // niche categorized in
                $post2["niche"] = "";
                $nicheObj = "";
                if(!empty($data2->poster)){
                    $userObj = xDb::get("user", "id", $data2->poster, "id, username, photo");
                    if(!empty($userObj)){
                        $post2["user"] = $userObj;
                    }
                }
                if(!empty($data2->category)){
                    $nicheObj = xDb::get("niche", "id", $data2->category, "id, alias");
                    if(!empty($nicheObj)){
                        $post2["niche"] = $nicheObj;
                    }
                }
                $post2["pic"] = "";
                $postPic2 = xDb::get("editor_post_image", "post", $data2->id, "path");
                if(!empty($postPic2)){
                    $post2["pic"] = $postPic2->path;
                }
                //stats
                $post2["following"] = xDb::getCount("post_followership", "*", "post", $data2->id);
                $post2["comments"] = xDb::getCount("post_comment", "*", "post", $data2->id);
                // check whether d current user has followed this post or not
                $post2["c_user_has_followed"] = 0;
                $post2["c_user_has_followed"] = count(xDb::find("post_followership", "*", "WHERE post = $data2->id AND follower = $userId"));
                // aggregate
                $responseData2[$ct2] = $post2;
                $ct2 += 1;
            }
            
            shuffle($responseData2);
            echo json_encode($responseData2);
        // }
        
    }
    function comments($request){
        $postId = $_SESSION["post_id"];
        $starting = $request->POST["starting"];
        $amount = $request->POST["amount"];
        $comments = xDb::find("post_comment", "*", "where post = $postId", "ORDER BY id DESC", "LIMIT $starting, $amount");
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