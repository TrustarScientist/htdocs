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
        
        // // scan through the current user's memberships
        // $memObjects = xDb::find("niche_membership", "*", "where member = $userId");
        // if(!empty($memObjects)){
        //     //get niche IDs
        //     $userNicheIds = array();
        //     foreach ($memObjects as $key => $mem) {
        //         array_push($userNicheIds, $mem->niche);
            
        //     }
        //     // scan thru some posts based on $starting position & $amount
        //     $somePosts = xDb::find("post", "*", "", "ORDER BY date_updated DESC", "LIMIT $starting, $amount");
        //     // echo json_encode($somePosts);
        //     $personalizedPosts = array();
        //     // filter posts based on user niches
        //     foreach ($somePosts as $key => $somePost) {
        //         if(in_array($somePost->category, $userNicheIds)){
        //             array_push($personalizedPosts, $somePost);
        //         }
        //     }
        //     //print_r($personalizedPosts);
        //     // add related data
        //     $responseData = array();
        //     $post = array();
        //     $ct = 0;
        //     foreach ($personalizedPosts as $data) {
        //         # code...
        //         $post["postid"] = $data->id;
        //         $post["title"] = $data->title;
        //         $post["slug"] = $data->slug;
        //         $post["content"] = $data->content;
        //         $post["updated"] = date("Y-M-d",strtotime($data->date_updated));
        //         $post["views"] = $data->views;
        //         // user who created
        //         $post["user"] = "";
        //         $userObj = "";
        //         // niche categorized in
        //         $post["niche"] = "";
        //         $nicheObj = "";
        //         if(!empty($data->poster)){
        //             $userObj = xDb::get("user", "id", $data->poster, "id, username, photo");
        //             if(!empty($userObj)){
        //                 $post["user"] = $userObj;
        //             }
        //         }
        //         if(!empty($data->category)){
        //             $nicheObj = xDb::get("niche", "id", $data->category, "id, alias");
        //             if(!empty($nicheObj)){
        //                 $post["niche"] = $nicheObj;
        //             }
        //         }
        //         $post["pic"] = "";
        //         $postPic = xDb::get("post_image", "post", $data->id, "path");
        //         if(!empty($postPic)){
        //             $post["pic"] = $postPic->path;
        //         }
        //         //stats
        //         $post["following"] = xDb::getCount("post_followership", "*", "post", $data->id);
        //         $post["comments"] = xDb::getCount("post_comment", "*", "post", $data->id);
        //         // check whether d current user has followed this post or not
        //         $post["c_user_has_followed"] = 0;
        //         $post["c_user_has_followed"] = count(xDb::find("post_followership", "*", "WHERE post = $data->id AND follower = $userId"));
        //         // aggregate
        //         $responseData[$ct] = $post;
        //         $ct += 1;
        //     }
            
        //     echo json_encode($responseData);
            
        // }else{
            $randomPosts = xDb::find("post", "*", "", "ORDER BY date_updated DESC", "LIMIT $starting, $amount");
            $responseData2 = array();
            $post2 = array();
            $ct2 = 0;
            foreach ($randomPosts as $data2) {
                # code...
                $post2["postid"] = $data2->id;
                $post2["title"] = $data2->title;
                $post2["slug"] = $data2->slug;
                $post2["content"] = $data2->content;
                $post2["updated"] = date("Y-M-d",strtotime($data2->date_updated));
                $post2["views"] = $data2->views;
                // user who created
                $post2["user"] = "";
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
                $postPic2 = xDb::get("post_image", "post", $data2->id, "path");
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