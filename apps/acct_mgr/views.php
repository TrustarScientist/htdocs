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
        "id, username, first_name, last_name, intro, date_registered, photo"
      );
      if(!empty($userObject)){
        if(empty($userObject->first_name)){
          $userObject->first_name = "";
        }
        if(empty($userObject->last_name)){
          $userObject->last_name = "";
        }
      }
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
  $selfInfo = function($request){
      $self = xDb::get("user", "id", $request->userid, "username, photo");
      echo json_encode($self);
  };
  $recommendedPeople4Self =  function($request){
    // array to store the current user's people connected to already...
    $recPeople = array();
    $recPos = 0;
    $users = array();
    $c_userNetwork = array();
    $pos = 0;
    $userId = $request->userid;
    $c_userInNetworks = xDb::find("user_network", "DISTINCT *", " WHERE (user1 = $userId) OR (user2 = $userId) " );
    if(!empty($c_userInNetworks)){
      foreach ($c_userInNetworks as $key => $personConnected2InNetwork) {
          // try getting the actual person the current user network to...each
        if($personConnected2InNetwork->user1 == $userId){
          $c_userNetwork[$pos] = $personConnected2InNetwork->user2;
        }
        else{
          $c_userNetwork[$pos] = $personConnected2InNetwork->user1;
        }
        // next position pls
        $pos += 1;
      }
        // after getting the people in the current user network, it's time to loop thru about 40 users on the platform
      // especially users that are old on the platform
      // filter against the user's network people above and prevent recommending user's self
      $users = xDb::find("user", "id, username, photo", "WHERE id != $userId ", "order by date_registered", "LIMIT 250 ");
      foreach ($users as $key => $user) {
            if(in_array($user->id, $c_userNetwork)){
                // do nothing
            }else{
              $user->is_liked = 0;
              // check wether current user already likes this person or not
              $likeness = xDb::find("user_likeness", "*", "WHERE liker = $userId AND liked = $user->id ");
              if(!empty($likeness)){
                $user->is_liked = 1;
              }
              // add to recommended people
              $recPeople[$recPos] = $user;
            }
            // next recPeople position
            $recPos += 1;
            
      }
      // return results
      $recPeople = (count($recPeople) > 5)? array_slice($recPeople, 0, 5) : $recPeople;
      echo json_encode($recPeople);
    }
    else{
      // just pick a set of 5 users randomly
    }
     
  };
  $likeness = function($request){
      /**
       * scan thru whether the current user already likes the person clicked or not
       * if already liked, remove like otherwise create likeness record accordingly
       * but if there are duplicate likes, delete them
       */
      $state = "";
      $userLiked = $request->POST["liked"];

      $likes = xDb::find("user_likeness", "*", "WHERE liker = $request->userid AND liked = $userLiked");
      
      if(!empty($likes)){
        // delete likeness record...and some possible duplicates
        $delResult = xDb::delete("user_likeness", "WHERE liker = $request->userid AND liked = $userLiked");
        $delResult = ((!empty($delResult))? "deleted": "err");
        echo $delResult;
      }
      else{
        $creationResult = xDb::create("user_likeness", array(
          "liker" => $request->userid,
          "liked" => $userLiked,
          "date" => date("Y-m-d")
        ));
        $creationResult = ((!empty($creationResult))? "created": "err");
        echo $creationResult;
      }
  };
  $blacklist = function($request){
       /**
       * scan thru whether the current user already blocked the person clicked or not
       * if already blocked, remove from blacklist otherwise create blacklist record accordingly
       */
      
      $userBlocked = $request->POST["user_to_block"];

      $blacklist = xDb::find("user_blacklist", "*", "WHERE blocker = $request->userid AND blocked = $userBlocked");
      
      if(!empty($blacklist)){
        // delete likeness record...and some possible duplicates
        $delResult = xDb::delete("user_blacklist", "WHERE blocker = $request->userid AND blocked = $userBlocked");
        $delResult = ((!empty($delResult))? "unblocked": "err");
        echo $delResult;
      }
      else{
        $creationResult = xDb::create("user_blacklist", array(
          "blocker" => $request->userid,
          "blocked" => $userBlocked,
          "date" => date("Y-m-d")
        ));
        $creationResult = ((!empty($creationResult))? "blocked": "err");
        echo $creationResult;
      }
  };
     
?>