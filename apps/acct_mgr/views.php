<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
  $profile = function($request, $profilePosts){
    // store acct to see on GET request after verifying that it is real and the profile page is loaded
    if($request->method == "GET"){
      $data4later = $profilePosts[1];
      $userObject = xDb::get("user", "username", $data4later, "id, username");
      if(!empty($userObject)){
        $_SESSION["profile"] = $userObject->id;
        // profile page
        render($request, "profile.html");
        
      }
      else{
        // respond with 404
        header("Location:/404#profilenotfound");
      }
      
    }
    else{
      // load from session if on POST request
      $profileId = $_SESSION["profile"];
      $userObject = xDb::get(
        "user",  
        "id",
        $profileId,
        "id, username, first_name, last_name, intro, date_registered"
      );
      echo json_encode($userObject);
    }
    
  };

  $userPosts = function($request){
    // profile gotten from POST request body
    $profileId = 0;
    $starting = 0;
    $amount = 1;
    if((isset($request->POST["profile_id"])) && (isset($request->POST["amount"])) && (isset($request->POST["starting"]))){
      $profileId = $request->POST["profile_id"];
      $starting = $request->POST["starting"];
      $amount = $request->POST["amount"];
    }
    $profilePosts = xDb::find("post", "*", "where poster = '$profileId'", "ORDER BY date_updated DESC", "limit $starting, $amount");
    $responseData =  array();
            $ct = 0;
            $post = array();
            if(!empty($profilePosts)){
                foreach ($profilePosts as $data) {
                    # code...
                    $post["postid"] = $data->id;
                    $post["title"] = $data->title;
                    $post["slug"] = $data->slug;
                    $post["content"] = $data->content;
                    $post["updated"] = $data->date_updated;
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
                        $nicheObj = xDb::get("niche", "id", $data->category, "id, alias");
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
      echo json_encode($responseData);
    }
  };
     
?>