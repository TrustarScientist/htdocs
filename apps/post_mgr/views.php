<?php
   require_once "engine/base-controllers/core.php";
   require_once "engine/base-controllers/core2.php";
   require_once "engine/base-models/models2.php";
    
  $newsfeed = function($request){
    if($request->is_authenticated){
        $starting = "0";
        $amount = "0";
        if(isset($request->POST["starting"])){
            $starting = $request->POST["starting"];
        }
        if(isset($request->POST["amount"])){
            $amount = $request->POST["amount"];
        }
        personalizedPost($request->userid, $starting, $amount);
    }
  };
  $postFollowing = function($request){
        //get post id
        $postId = $_POST["post_id"];
        // check for duplicate following and remove one
        $postFollowership = xDb::find("post_followership", "*", "where post = $postId and follower = $request->userid");
        if(count($postFollowership) > 1){
            // delete duplicates
            
            for ($i=1; $i < count($postFollowership); $i++) { 
                    $postFollowershipId = ($postFollowership[$i])->id;
                    $result = xDb::delete("post_followership", "where id = $postFollowershipId");
            }
            // delete record
            $firstRecord = ($postFollowership[0])->id;
            $deletionResult =  xDb::delete("post_followership", "where id = $firstRecord and follower = $request->userid");
            echo ((!empty($deletionResult)) ?  "deleted" : "err");
           
        }
        else{
            // continue processing
            // if empty , it means the current user is not yet following this post
            if(empty($postFollowership)){
                $creationResult = xDb::create("post_followership", array(
                    "id" => null,
                    "post" => $postId,
                    "follower" => $request->userid,
                    "date" =>  date("Y-m-d")
                    
                ), true);
                echo ((!empty($creationResult)) ?  "created" : "err");
            }
            else{
                $deletionResult =  xDb::delete("post_followership", "where post = $postId and follower = $request->userid");
                echo ((!empty($deletionResult)) ?  "deleted" : "err");
                
            }
        }
  };
   $latest = function($request){
       if($request->method == "POST"){
            // starting point & amount values are assumed
            $starting = $request->POST["starting"];
            $amount = $request->POST["amount"];
            $dataset = xDb::trending("post", "views", $starting, $amount);
            $responseData =  array();
            $ct = 0;
            $post = array();
            if(!empty($dataset)){
                foreach ($dataset as $data) {
                    # code...
                    $post["postid"] = $data->id;
                    $post["title"] = $data->title;
                    $post["slug"] = $data->slug;
                    $post["content"] = $data->content;
                    $post["updated"] = date("Y-M-d",strtotime($data->date_updated));
                    $post["views"] = $data->views;
                    // user who created
                    $post["user"] = "";
                    $userObj = "";
                    // niche categorized in
                    $post["niche"] = "";
                    $nicheObj = "";
                    if(!empty($data->poster)){
                        $userObj = xDb::get("user", "id", $data->poster, "id, username");
                        if(!empty($userObj)){
                            $post["user"] = $userObj;
                        }
                    }
                    if(!empty($data->category)){
                        $nicheObj = xDb::get("niche", "id", $data->category, "*");
                        if(!empty($nicheObj)){
                            $post["niche"] = $nicheObj;
                        }
                    }
                    $post["pic"] = "";
                    $postPic = xDb::get("post_image", "post", $data->id, "path");
                    if(!empty($postPic)){
                        $post["pic"] = $postPic->path;
                    }
                    //stats
                    $post["following"] = xDb::getCount("post_followership", "*", "post", $data->id);
                    $post["comments"] = xDb::getCount("post_comment", "*", "post", $data->id);
                    // aggregate
                    $responseData[$ct] = $post;
                    $ct += 1;
                }
                echo json_encode($responseData);
            }
            else{
                echo json_encode(array());
            }
            
       }
   };
   $editor = function($request){
        if($request->is_authenticated){
            render($request, "pvt/post-editor.html");
        }
        else{
            header("Location:/login");
        }
   };
   $postComments = function($request){
        comments($request);
   };
   $postDetailsPage = function($request, $dataset){
        if($request->method == "GET"){
            $postId = $dataset[1];
            $slug = $dataset[2];
            $postObject = xDb::get("post", "id", $postId, "*");
            if(!empty($postObject)){
            $_SESSION["post_id"] = $postObject->id;
            $_SESSION["is_viewed"] = 0;
            
            // profile page
            render($request, "post-details.html");
            
            }
            else{
                // respond with 404
                header("Location:/404#postnotfound");
            
            }
            
        }
        else{
            // bla bla bla...
        }
   };
   $postDetails = function($request){
    // load from session if on POST request
            if(isset($_SESSION["post_id"])){
                $postId = $_SESSION["post_id"];
                $postObject = xDb::get("post", "id", $postId, "*");
                
                // get relation niche, poster & content type info
                $nicheObject = xDb::get("niche", "id", $postObject->category);
                if(!empty($nicheObject)){
                    $postObject->category = $nicheObject; 
                }
                $userObject = xDb::get("user", "id", $postObject->poster, "id, username, photo");
                if(!empty($userObject)){
                    $postObject->poster = $userObject;
                }
                $contentTypeObj = xDb::get("contenttype", "id", $postObject->content_type);
                if(!empty($contentTypeObj)){
                    $postObject->content_type = $contentTypeObj;
                }
                // format date
                $postObject->date_updated = date("Y-M-d",strtotime($postObject->date_updated));
                //photos attached to post
                $photos = xDb::find("post_image", "path", "where post = $postId");
                $postObject->photos = $photos;
                // update views count
                $views = (int) $postObject->views;
                $views += 1;
                $result = xDb::update("post", array(

                    "views" => $views,

                ), "where id = $postId ");
                $postObject->views += $result;
                $_SESSION["is_viewed"] = 1;
                // check attached videos
                $postVideo = xDb::get("post_video", "post", $postId);
                $postObject->video = $postVideo;
                // prev and next
                // stats of people following, comments
                $followings = xDb::getCount("post_followership", "*", "post", $postId);
                $comments = xDb::getCount("post_comment", "*", "post", $postId);
                $postObject->followings = $followings;
                $postObject->comments = $comments;
                // respond with data
                //related posts
                $relatedPosts = xDb::postSearch("post", "title", $postObject->title, "0", "5");
                if(!empty($relatedPosts)){
                    foreach ($relatedPosts as $key => $rPost) {
                            if($rPost->id == $postId){
                                array_splice($relatedPosts,$key, 1);
                            }
                    }
                }
                $postObject->related_posts = $relatedPosts;

                echo json_encode($postObject);
            }
            else{
                header("Location:/404#postnotfound");
            }
   };
   $commentReplies = function($request){
        $commentId = $_POST["comment_id"];
        $replies = xDb::find("post_comment_reply", "*", "where comment = $commentId");
        if(!empty($replies)){
            foreach ($replies as $key => $reply) {
                    $reply->replyer = xDb::get("user", "id", $reply->replyer, "username");
            }
        }
        echo json_encode($replies);
   };
   
    
?>