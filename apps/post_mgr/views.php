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
                    $postPic = xDb::get("editor_post_image", "post", $data->id, "path");
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
            if(!$request->is_authenticated){
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
                    header("Location:/404#post-not-found");
                
                }
            }else{
                // authenticated post details page
                $postId = $dataset[1];
                $slug = $dataset[2];
                $postObject = xDb::get("post", "id", $postId, "*");
                if(!empty($postObject)){
                $_SESSION["post_id"] = $postObject->id;
                $_SESSION["is_viewed"] = 0;
                
                // profile page
                render($request, "pvt/pvt-post-details.html");
                
                }
                else{
                    // respond with 404
                    header("Location:/404#pvt-post-not-found");
                
                }
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
                // content 
                $postObject->content = html_entity_decode($postObject->content);




                $contentTypeObj = xDb::get("contenttype", "id", $postObject->content_type);
                if(!empty($contentTypeObj)){
                    $postObject->content_type = $contentTypeObj;
                }
                // format date
                $postObject->date_updated = date("Y-M-d",strtotime($postObject->date_updated));
                //photos attached to post
                $photos = xDb::find("editor_post_image", "path", "where post = $postId");
                $postObject->photos = $photos;
                // update views count
                $views = (int) $postObject->views;
                $views += 1;
                $result = xDb::update("post", array(

                    "views" => $views,

                ), "where id = $postId ");
                $postObject->views += $result;
                $_SESSION["is_viewed"] = 1;
               
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
   $pvtPostDetails = function($request){
        $postId = $request->POST["postid"];
        $postResult = xDb::get("post", "id", $postId);

        if(!empty($postResult)){
            // update views count
            
            $updated = xDb::update("post", array(
                "views" => (((int) ($postResult->views) ) + 1)
            ), " WHERE id = $postId");
            
            // get related data
            $postResult->content = htmlspecialchars_decode($postResult->content);
            $postResult->owned_by_cuser = false;
            if($postResult->poster == $request->userid){
                $postResult->owned_by_cuser = true;
            }
            $postResult->poster = xDb::get("user", "id", $postResult->poster, "id, username, photo");
            $postResult->content_type = xDb::get("contenttype", "id", $postResult->content_type);
            $postResult->category = xDb::get("niche", "id", $postResult->category);
            $postResult->following = xDb::getCount("post_followership", "*", "post", $postResult->id);
            $postResult->comments = xDb::getCount("post_comment", "*", "post", $postResult->id);
            // send aggregate response
            echo json_encode($postResult);
        }else{
            echo json_encode(array());
        }
   };
   $commentAdd = function($request){
        $content = $request->POST["content"];
        $postId = $request->POST["postid"];
        $commenterId = $request->userid;
        $result = xDb::create("post_comment", array(
            "commenter" => $commenterId,
            "post"=> $postId,
            "content" => htmlentities(addslashes($content)),
            "date_created" => date("Y-m-d H:i:s")
        ));
        if(!empty($result)){
            echo "1";
        }else{
            echo "0";
        }
   };
   $commentReplies = function($request){
        $commentId = $_POST["comment_id"];
        $replies = xDb::find("post_comment_reply", "*", "where comment = $commentId","  ORDER BY id DESC ", "LIMIT 25");
        if(!empty($replies)){
            foreach ($replies as $key => $reply) {
                    $reply->replyer = xDb::get("user", "id", $reply->replyer, "username");
            }
            echo json_encode($replies);
        }else{
            echo json_encode(array());
        }
        
   };
   $replyAdd = function($request){
    $replyer = $request->userid;
    $body = $request->POST["reply-body"];
    $commentId = $request->POST["cid"];
    if($body != ""){
        $result = xDb::create("post_comment_reply", array(
            "comment" => $commentId,
            "replyer" => $replyer,
            "content" => htmlentities(addslashes($body)),
            "date" => date("Y-m-d H:i:s"),
        ));
        if(!empty($result)){
            echo "1";
        }else{
            echo "0";
        }
    }else{
        echo "-1";
    }
    
   };

   $imageUploader = function($request){
    $response = array();
      // get photo if available
      /**
       *  we should process the image if and only if the image is truely uploaded, not less than 1, not more than 2 MB
       */
      if((isset($request->FILES["upload"])) && ($request->FILES["upload"]["size"] > 0) && ($request->FILES["upload"]["size"] < 5000000)){
          /**
         *  We need to manage the files first before storing other data
         *  the file needs to be stored in the File System with unique,tokenized naming
         */
        // store file in file system
        $dbRecordString = "";
        // generate token for file name uniqueness
        $tokenChars = array(
          "a1", "b2", "c3", "d4", "e5", "f5", "g6", "h7", "i8", "j9", "k10", "l11", "m12", "n13", "o14", "p15","q16", "r17", "s18", "t19", "u20", "v21", "w22", "x3", "y24", "z25",
          "26A", "25B", "24C", "23D", "22E", "21F", "20G", "19H", "18I", "17J", "16K", "15L", "14M", "13N", "12O", "11P", "10Q", "9R", "8S", "7T", "6U", "5V", "4W", "3X","2Y", "1Z"
        );
        $tokenIndex1  = rand(0, count($tokenChars)-1);
        $tokenIndex2  = rand(0, count($tokenChars)-1);
        $tokenIndex3  = rand(0, count($tokenChars)-1);
        $token =  $tokenChars[$tokenIndex1] . $tokenIndex1 . $tokenChars[$tokenIndex2] . $tokenIndex2 . $tokenChars[$tokenIndex3] . $tokenIndex3 . "-";
        // attempt storing it in FS
        $user = xDb::get("user", "id", $request->userid, "username,photo");
  
        $dbRecordString = $user->username . "-" . $token . basename($request->FILES["upload"]["name"]);
        $uploadPath = "storage/post/" . $dbRecordString;
        if(move_uploaded_file($request->FILES["upload"]["tmp_name"], $uploadPath)){
  
          /**
           *  now that the file is saved in FS successfully, let's update the DB records
           */
  
  
          try {
            xDb::create(
                "editor_post_image",
                array(
                        "path" => $dbRecordString
                    )
                );
            
            $response["url"] = "/storage/post/" . $dbRecordString;
            
    
          } catch (\Throwable $th) {
            //throw $th;
            
            
          }
        }
  
        
        // finally...return response
        echo json_encode($response);
    }
   };
   
   $createPost = function($request){
    $postVisibility = (isset($request->POST["visibility"])) ? $request->POST["visibility"]: "pub";
    $postType = (isset($request->POST["type"])) ? $request->POST["type"] : 1;
    $postNiche = (isset($request->POST["category"])) ? $request->POST["category"] : 7;
    $postTitle = (isset($request->POST["title"])) ? $request->POST["title"] : "An Anomymous Post...Can't Be Trusted!";
    $content =  htmlspecialchars($request->POST["content"], ENT_QUOTES);
    $acctId =  $request->userid;

    preg_match_all('/<img\s+src=[a-zA-Z0-9" *":,.!-().?";\']\/storage\/post\/([_@*\w.+&^:$?=%-]+)[a-zA-Z0-9" *":,.!-().?";\']>/', $request->POST["content"], $matches);
    //get post images for later processing
    $postImages = array();
    if(isset($matches[1])){
        $postImages = $matches[1];
    }

    $date_created = date("Y-m-d H:i:s");
    $date_updated = date("Y-m-d H:i:s");
    // generate a token for post uniqueness for later processing
    $specialChars = ["@", "#", "*", "$","%", "&", "^", "!", "_", "=", "~", "?"];
    $token = $specialChars[rand(0, (count($specialChars)-1))] . $specialChars[rand(0, (count($specialChars)-1))] . $postTitle . $specialChars[rand(0, (count($specialChars)-1))] . $specialChars[rand(0, (count($specialChars)-1))];
    // attempt post storage
    $state = xDb::create("post", array(
        "visibility" => $postVisibility,
        "content_type" => $postType,
        "category" => $postNiche,
        "poster" => $acctId,
        "title" => $postTitle,
        "date_created" => $date_created,
        "date_updated" => $date_updated,
        "content" => $content,
        "token" => $token,
    ));

    if(!empty($state)){
        // link images to the post id
        $thisPostId = (xDb::get("post", "token", $token, "id"))->id;
        foreach ($postImages as $key => $postImage) {
            $ur = xDb::update("editor_post_image", array(
                "post" => $thisPostId
            ), "WHERE path = '$postImage'");
            
        }
        // delete all post images that are not linked
        $unlinkedImages = xDb::find("editor_post_image", "*", "WHERE post IS NULL ");
        foreach ($unlinkedImages as $key => $unlinkedImage) {
            xDb::delete("editor_post_image", "WHERE id = '$unlinkedImage->id'");
            unlink("storage/post/" . $unlinkedImage->path);
        }
        echo "1";
    }else{
        // delete images instead...from DB ENGINE & FILE SYSTEM
        foreach ($postImages as $key => $pImage) {
            xDb::delete("editor_post_image", "WHERE path = '$pImage'");
            unlink("storage/post/" . $pImage);
        }
        echo "0";
    }

   };
    
    $post2Edit =  function($request){
        $postId = isset($request->POST["post2edit"])? $request->POST["post2edit"]: 0;
        $postObject = xDb::get("post", "id", $postId);
        if((!empty($postObject)) && ($postObject->poster == $request->userid)){
            $postObject->content =  html_entity_decode($postObject->content);
            echo  json_encode($postObject);
        }else{
            echo  json_encode(false);
        }
        
   };

   $updatePost = function($request){

        $postId = $request->POST["postid"];
        $postVisibility = (isset($request->POST["visibility"])) ? $request->POST["visibility"]: "pub";
        $postType = (isset($request->POST["type"])) ? $request->POST["type"] : 1;
        $postNiche = (isset($request->POST["category"])) ? $request->POST["category"] : 7;
        $postTitle = (isset($request->POST["title"])) ? $request->POST["title"] : "An Anomymous Post...Can't Be Updated!";
        $content =  htmlspecialchars($request->POST["content"], ENT_QUOTES);
        $acctId =  $request->userid;
    
        $date_updated = date("Y-m-d H:i:s");
        // let's get the images in this updated post
        preg_match_all('/<img\s+src=[a-zA-Z0-9" *":,.!-().?";\']\/storage\/post\/([_@*\w.+&^:$?=%-]+)[a-zA-Z0-9" *":,.!-().?";\']>/', $request->POST["content"], $matches2);
        $uPostImages = array();
        if(isset($matches2[1])){
            $uPostImages = $matches2[1];
        }
        

        $state = xDb::update("post", array(
            "visibility" => $postVisibility,
            "content_type" => $postType,
            "category" => $postNiche,
            "poster" => $acctId,
            "title" => $postTitle,
            "date_updated" => $date_updated,
            "content" => $content

        ), "WHERE id = $postId AND poster = $acctId");

        if(!empty($state)){
            // link up the images to this post id
            foreach ($uPostImages as $key => $uPostImage) {
                xDb::update("editor_post_image", array(
                    "post" => $postId
                ), "WHERE path = '$uPostImage'");
            }
            // get all the images linked to this post id
            $linkedImages = xDb::find("editor_post_image", "*", "WHERE post = '$postId' ");
            foreach ($linkedImages as $key => $linkedImage) {
                // remove images that are not in this post content
                if(!in_array($linkedImage->path, $uPostImages)){
                    xDb::delete("editor_post_image", "WHERE path = '$linkedImage->path'");
                    unlink("storage/post/" . $linkedImage->path);
                }
            }
            echo "1";
        }else{
            echo "0";
        }
   };

   $cUserPosts = function($request){
        $starting = (isset($request->POST["starting"]))? $request->POST["starting"] : 0;
        $amount = (isset($request->POST["amount"]))? $request->POST["amount"] : 0;
        $cUserPostsData = xDb::find("post", "id, title, date_updated, slug, content_type", "WHERE poster = $request->userid", "ORDER BY date_updated DESC ", "LIMIT $starting, $amount");
        if(!empty($cUserPostsData)){
            foreach ($cUserPostsData as $key => $cupd) {
                $cupd->content_type = xDb::get("contenttype", "id", $cupd->content_type, "name");
            }
            echo json_encode($cUserPostsData);
        }else{
            echo json_encode(array());
        }
   };


   $cUserPostsSearch  = function($request){
        $terms = $request->POST["terms"];
        if($terms == ""){
            echo json_encode(array());
        }else{
            $result = xDb::find("post", "id, title", " WHERE poster = $request->userid AND title LIKE '%$terms%' ", "ORDER BY date_updated", "LIMIT 12");
            echo json_encode($result);
        }
   };



   $deletePost = function($request){
        $pid = $request->POST["pid"];
        // ensure the post belongs to the current user
        $result = xDb::delete("post", "WHERE id = $pid AND poster = $request->userid");
        if(!empty($result)){
            echo "1";
        }else{
            echo "0";
        }
   };

?>