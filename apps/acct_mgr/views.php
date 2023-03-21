<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
  $profile = function($request, $profileName){
    // store acct to see on GET request after verifying that it is real and the profile page is loaded
    if($request->method == "GET"){
      // let's check whether the user is authenticated or not & display appropriate pages
      if($request->is_authenticated){
        $data4later = $profileName[1];
        $userObject = xDb::get("user", "username", $data4later, "id, username");
        if(!empty($userObject)){
          $_SESSION["profile"] = $userObject->id;
          // profile page
          render($request, "pvt/pvt-profile.html");
          
        }
        else{
          // respond with 404
          header("Location:/404#privateprofilenotfound");

        }
      }
      else{
        $data4later = $profileName[1];
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
      
    }
    else{
      // load from session if on POST request
      // if not authenticated
      if(!$request->is_authenticated){
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
      }else{
        // POST request but logged in
        $acctId = $_SESSION["profile"];
        /**
         *  get the acct info except private data such as password
         *  return an empty array if acct can't be found
         */
        $acctObject = xDb::get("user", "id", $acctId);
        // remove password
        if(!empty($acctObject)){
          $acctObject->password = "";
          $acctObject->fans = 0;
          $fans = xDb::find("user_likeness", "*", "WHERE liked = $acctObject->id AND liker != $acctObject->id");
          $acctObject->fans = count($fans);
          // acct liking how many?
          $acctObject->liking = 0;
          $liking = xDb::find("user_likeness", "*", "WHERE liker  = $acctObject->id AND liked != $acctObject->id");
          $acctObject->liking = count($liking);
          //
          
          $acctObject->c_user_profile = 0;
          if($request->userid == $acctId){
            $acctObject->c_user_profile = 1;
          }
          $acctObject->friend_request_allowed = 0;
          
          // check friend request & user network
          $uNet = xDb::find("user_network", "*", " WHERE (user1 = $acctObject->id AND user2 = $request->userid) OR (user2 = $acctObject->id AND user1 = $request->userid ) ");
          $uFr =  xDb::find("user_connection", "*", "WHERE sender = $request->userid AND receiver = $acctObject->id ");
          if((empty($uNet)) && (empty($uFr))){
            $acctObject->friend_request_allowed = 1;
          }
          // acct can't send friend request to self.
          if($request->userid == $acctObject->id){
            $acctObject->friend_request_allowed = -1;
          }
          // can current user like acct or not?
          $acctObject->c_user_has_liked_acct = 0;
          $acctLikeness = xDb::find("user_likeness", "*", "WHERE (liker = $request->userid AND liked = $acctObject->id) OR (liked = $request->userid AND liker = $acctObject->id) ");
          if(!empty($acctLikeness)){
            $acctObject->c_user_has_liked_acct = 1;
          }
          
          echo json_encode($acctObject);
        }else{
          echo json_encode(array());
        }
        

        
      }




    }
    
  };


  $networkedPeople = function($request){
    $starting = (isset($request->POST["starting"]))? $request->POST["starting"]: 0;
    $amount = (isset($request->POST["amount"]))? $request->POST["amount"]: 1;
    // acct to get people connected to it is required!
    $response = array();
    $nPeople = array();
    $acctId = (isset($request->POST["acct-id"])) ? $request->POST["acct-id"] : $request->userid;

    $peopleConnectedToAcct = xDb::find("user_network", "*", "WHERE (user1 = $acctId AND user2 != $acctId) OR  (user2 = $acctId AND user1 != $acctId) ", "", "LIMIT $starting, $amount");
    
    if(!empty($peopleConnectedToAcct)){
      foreach ($peopleConnectedToAcct as $key => $relation) {
        # code...to get each person in the network...instead of the relationship itself
        if($relation->user1 == $acctId){
          array_push($nPeople, $relation->user2);
        }else{
          array_push($nPeople, $relation->user1);
        }
        
      }
      // get info about each person if not empty
      foreach ($nPeople as $key => $personId) {
        $acct = xDb::get("user", "id", $personId, "id, username, photo");
        array_push($response, $acct);
      }
      // respond with data
      echo json_encode($response);






    }else{
      // return empty array since no network
      echo json_encode($response);
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
      // order
      $orderCode = (isset($request->POST["order-code"])? $request->POST["order-code"]: "date_updated DESC");
      
    }
    $profilePosts = xDb::find("post", "*", "where poster = '$profileId'", "ORDER BY $orderCode", "limit $starting, $amount");
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
                        $userObj = xDb::get("user", "id", $data->poster, "id, username, photo");
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
                    // check whether d current user has followed this post or not
                    $post["c_user_has_followed"] = 0;
                    $post["c_user_has_followed"] = count(xDb::find("post_followership", "*", "WHERE post = $data->id AND follower = $request->userid"));
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

  $acctNiches = function($request){
    $niches = array();
    $acctId = (isset($request->POST["acct-id"])) ? $request->POST["acct-id"] : $request->userid;
    
    $starting = (isset($request->POST["starting"])? $request->POST["starting"]: 0);
    $amount = (isset($request->POST["amount"])? $request->POST["amount"]: 1);
  
    $nichesIn = xDb::find("niche_membership", "DISTINCT * ", "WHERE member = $acctId", "", "LIMIT $starting, $amount");
    if(!empty($nichesIn)){
      foreach ($nichesIn as $key => $nicheIn) {
        $n = xDb::get("niche", "id", $nicheIn->niche);
        $n->members = xDb::getCount("niche_membership", "*", "niche", $nicheIn->niche);
        // check whether the current user already a member of each or not
        $n->c_user_is_member = 0;
        $n->c_user_is_member = count(xDb::find("niche_membership", "*", "WHERE niche = $nicheIn->niche AND member = $request->userid"));
        $n->posts = xDb::getCount("post", "*", "category", $nicheIn->niche);
        array_push($niches, $n);
      }
    }
    echo json_encode($niches);

  };

  $recommendedNiches = function($request){
    // for the current user by default
    $user4 = $request->userid;
    // get some niches
    $niches = xDb::find("niche", "*", "", "ORDER BY rank", "LIMIT 100");
    $acctMemberships = xDb::find("niche_membership", "*", "WHERE member = $user4");
    $acctNiches = array();
    foreach ($acctMemberships as $key => $acctMem) {
      array_push($acctNiches, $acctMem->niche);
    }
    $recNiches = array();
    foreach ($niches as $key => $n) {
      if(!in_array($n->id, $acctNiches)){
        array_push($recNiches, $n);
      }
    }
    shuffle($recNiches);

    foreach ($recNiches as $key => $recN) {
      $recN->members = xDb::getCount("niche_membership", "*", "niche", $recN->id);
      $recN->posts = xDb::getCount("post", "*", "category", $recN->id);
    }

    if(count($recNiches) > 3){
      echo json_encode(array_slice($recNiches, 0, 2));
    }else{
      echo json_encode($recNiches);
    }
  };

  $selfInfo = function($request){
      $self = xDb::get("user", "id", $request->userid, "username, photo");
      echo json_encode($self);
  };

  $profileUpdate = function($request){
    $response = array(
      "state" => 0,
      "errors" => "", 
    );
    // get photo if available
    /**
     *  we should process the image if and only if the image is truely uploaded, not less than 1, not more than 2 MB
     */
    if((isset($request->FILES["profile_photo"])) && ($request->FILES["profile_photo"]["size"] > 0) && ($request->FILES["profile_photo"]["size"] < 2000000)){
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

      $dbRecordString = $user->username . "-" . $token . basename($request->FILES["profile_photo"]["name"]);
      $uploadPath = "storage/profile/" . $dbRecordString;
      if(move_uploaded_file($request->FILES["profile_photo"]["tmp_name"], $uploadPath)){
        /**
         *  let's delete the previous photo uploaded by this user if not the default icon
         */
        if($user->photo != "user2.png"){
          unlink("storage/profile/" . $user->photo);
        }

        /**
         *  now that the file is saved in FS successfully, let's update the DB records
         */


        try {
          
          xDb::update("user", array(
            "email" => addslashes(htmlentities($request->POST["email"])),
            // "username" => addslashes(htmlentities($request->POST["username"])),
            "phone_number" => addslashes(htmlentities($request->POST["phone_number"])),
            "first_name" => addslashes(htmlentities($request->POST["fname"])),
            "last_name" => addslashes(htmlentities($request->POST["lname"])),
            "dob" => addslashes(htmlentities($request->POST["dob"])),
            "photo" => $dbRecordString,
            "nationality" => addslashes(htmlentities($request->POST["nationality"])),
            "gender" => addslashes(htmlentities($request->POST["gender"])),
            "intro" => addslashes(htmlentities($request->POST["intro"])),
            "school_info" => addslashes(htmlentities($request->POST["school_info"])),
            "work_info" => addslashes(htmlentities($request->POST["work_info"])),
            "hobbies" => addslashes(htmlentities($request->POST["hobbies"])),
            "relationship" => addslashes(htmlentities($request->POST["relationship_status"])),
  
  
          ),"WHERE id = $request->userid");
  
          $response["state"] = 1;
          $response["errors"] = "";
  
        } catch (\Throwable $th) {
          //throw $th;
          
          $response["state"] = -1;
          $response["errors"] = "[record not saved]";
        }
      }else{
        // we can't continue anything...so change response state to a negative value
        $response["state"] = -1;
        $response["errors"] = "[image could not be stored]";
      }

      
      // finally...return response
      echo json_encode($response);
      
      
    }else{
      /**
       *  since there is no file uploaded, just update the DB records appropriately
       */
      
      try {
          
        $result = xDb::update("user", array(
          "email" => addslashes(htmlentities($request->POST["email"])),
          // "username" => addslashes(htmlentities($request->POST["username"])),
          "phone_number" => addslashes(htmlentities($request->POST["phone_number"])),
          "first_name" => addslashes(htmlentities($request->POST["fname"])),
          "last_name" => addslashes(htmlentities($request->POST["lname"])),
          "dob" => addslashes(htmlentities($request->POST["dob"])),
          "nationality" => addslashes(htmlentities($request->POST["nationality"])),
          "gender" => addslashes(htmlentities($request->POST["gender"])),
          "intro" => addslashes(htmlentities($request->POST["intro"])),
          "school_info" => addslashes(htmlentities($request->POST["school_info"])),
          "work_info" => addslashes(htmlentities($request->POST["work_info"])),
          "hobbies" => addslashes(htmlentities($request->POST["hobbies"])),
          "relationship" => addslashes(htmlentities($request->POST["relationship_status"])),


        ),"WHERE id = $request->userid");
       
        $response["state"] = 1;
        $response["errors"] = "";

      } catch (\Throwable $th) {
        //throw $th;
        
        $response["state"] = -1;
        $response["errors"] = "[non-file record not saved]";
      }

        // finally...return response
      echo json_encode($response);
    }

  };

  $recommendedPeople4Self =  function($request){
    $acctId = $request->userid;
    $starting = 0;
    $amount  = 0 ;
    // get acct, starting & amount values
    if((isset($request->POST["acct"]))){
      $acctId = $$request->POST["acct"];
    }
    if(isset($request->POST["starting"])){
      $starting = $request->POST["starting"];
    }
    if(isset($request->POST["amount"])){
      $amount = $request->POST["amount"];
    }
    /**
     *  we need to scan through all the people in the acct's network
     *  so that we don't recommend them 
     *  if no network, just respond with older accounts on this platform.
     */
    $acctNetwork = xDb::find("user_network", "DISTINCT * ", "WHERE (user1 = $acctId) OR (user2 = $acctId) ");
    // store known people in the network...if network not empty
    //print_r($acctNetwork);
    $knownPeople = array();
    if(!empty($acctNetwork)){
      foreach ($acctNetwork as $key => $acctNetworkRecord) {
        # code...
        if($acctNetworkRecord->user1 == $acctId){
          array_push($knownPeople, $acctNetworkRecord->user2);
        }else{
          array_push($knownPeople, $acctNetworkRecord->user1);
        }
      }
        /**
       * 
       *  we need to have an array to store users that are not known...of course as recommendation
       *  we need to scan thru about 1000 accounts
       *  let's shuffle the filtered people recommended...so that it looks like AI thing
       */
      
      $filteredUsers  = array();
      $users = xDb::find("user", "id, username, photo");
      if(!empty($users)){
        foreach ($users as $key => $user) {
          // remove current user if in filtered users
          if((!in_array($user->id, $knownPeople)) && ($user->id != $request->userid)){
            array_push($filteredUsers, $user);
          }
        }
      }

      // shuffle
      shuffle($filteredUsers);
      // get 7 elements from the array
      if(count($filteredUsers) > 7){
        echo json_encode(array_splice($filteredUsers, 0, 4));
      }else{
        echo json_encode($filteredUsers);
      }
      
      



    }
    else{
      // no network linear...recommendation activated
      $someUsers = xDb::find("user", "id, username, photo", " WHERE id != $request->userid ", "ORDER BY date_registered DESC ", "LIMIT 0, 5");
      echo json_encode($someUsers);
    }
    

  };


  $likeness = function($request){
      /**
       * scan thru whether the current user already likes the person clicked or not
       * if already liked, remove like otherwise create likeness record accordingly
       * but if there are duplicate likes, delete them
       */
      $state = "";
      $user2Like = $request->POST["liked"];

      $likes = xDb::find("user_likeness", "*", "WHERE liker = $request->userid AND liked = $user2Like");
      
      if(!empty($likes)){
        // delete likeness record...and some possible duplicates
        $delResult = xDb::delete("user_likeness", "WHERE liker = $request->userid AND liked = $user2Like");
        $delResult = ((!empty($delResult))? "deleted": "err");
        echo $delResult;
      }
      else{
        $creationResult = xDb::create("user_likeness", array(
          "liker" => $request->userid,
          "liked" => $user2Like,
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
  $connections = function($request){
    if($request->is_authenticated){
      render($request, "pvt/connections.html");
    }
    else{
      header("Location:/login");
    }
   };
  $friendRequests = function($request){
    /**
     *  we have to fetch distinct friend requests
     *  we need to ensure the current user does not send friend request to itself
     */

    $starting = 0;
    $amount = 1;
    $starting = $request->POST["starting"];
    $amount = $request->POST["amount"];
    $fRequests = xDb::find("user_connection", "DISTINCT *", "WHERE receiver = $request->userid AND sender != $request->userid  ", "ORDER BY id desc", "LIMIT $starting, $amount");
    if(!empty($fRequests)){
      foreach ($fRequests as $key => $fR) {
        $fR->sender = xDb::get("user", "id", $fR->sender, "id, username, photo");
        $fR->starting = $starting;
        $fR->amount = $amount;
      }
    }
    
    echo json_encode($fRequests);
  };

  $sendFriendRequest = function($request){
    $response = 0;
    $personId = $request->POST["person-id"];
    $c_user = $request->userid;
    /**
     *  check whether a similar request is made already 
     *  
     */
    $similarFr = xDb::find("user_connection", "*", " WHERE sender = $c_user AND receiver = $personId");
    if(empty($similarFr)){

      // attempt saaving FR
      $creationState = xDb::create("user_connection", array(
        "sender" => $c_user,
        "receiver" => $personId,
        "date" => date("Y-m-d")
      )); 
      // on success, check for duplicates and keep only one record
      if($creationState){
        // change state to 'ok'
        $response = 1;
      }else{
        $response = -1;
      }
      // respond
      echo $response;
      
    }else{
      $response = 0;
      echo $response;
    
    }
    
    
    // /**
    //  *  firstly, we need to check whether a similar request is already sent 
    //  *  and there is no active connection between
    //  */
    // $finalState = 0;
    // if(!empty($activeNetworks = xDb::find("user_network", "*", "WHERE (user1 = $request->userid AND user2 = $personId) OR (user2 = $request->userid AND user1 = $personId) "))){
    //   // that means there is an active connection...reply with -ve...delete all occurrences
    //   foreach ($activeNetworks as $key => $aN) {
    //     # code...
    //     xDb::delete("user_network", "WHERE id = $aN->id");
        
    //   }
    //   // delete corresponding friend request record(s)
    //   $frRecords = xDb::find("user_connection","*", "WHERE receiver = $personId AND sender = $request->userid");
    //   if(!empty($frRecords)){
    //     foreach ($frRecords as $key => $frRecord) {
    //       xDb::delete("user_connection", "WHERE id = $frRecord->id");
    //     }
    //   }
    //   $finalState = -1;
      
    // }else{
    //   // remove duplicate friend requests if any
    //   $dupFrs = xDb::find("user_connection", "*", "WHERE sender = $request->userid AND receiver = $personId AND state = 1");
    //   if(!empty($dupFrs)){
    //     foreach ($dupFrs as $key => $dupFr) {
    //       # code...
    //       xDb::delete("user_connection", "WHERE id = $dupFr->id");
    //     }
    //     // check if not FR from self
    //     if($request->userid != $personId){
    //       // create new record
    //       xDb::create("user_connection", array(
    //         "sender" => $request->userid,
    //         "receiver" => $personId,
    //         "date" => date("Y-m-d H:i:s")
    //         // default 'state' value
    //       ));
    //       $finalState = 1;
    //     }else{
    //       $finalState = -1;
    //     }
    //   }else{
    //     // every is good ...so create the fr record
    //     if($request->userid != $personId){
    //       // create new record
    //       xDb::create("user_network", array(
    //         "sender" => $request->userid,
    //         "receiver" => $personId,
    //         "date" => date("Y-m-d H:i:s")
    //         // default 'state' value
    //       ));
    //       $finalState = 1;
    //     }else{
    //       $finalState = -1;
    //     }
    //   }
      
    // }
    // // send response
    // echo $finalState;
  };

  $friendshipStop = function($request){
    $person2Stop = $request->POST["person-2-stop-id"];
    $state = 0;
    // we need to remove the network as well as other possible duplicates
    $friendShips = xDb::find("user_network", "*", "  WHERE (user1 = $request->userid AND user2 = $person2Stop) OR (user1 = $person2Stop AND user2 = $request->userid) ");
    if(!empty($friendShips)){
      foreach ($friendShips as $key => $fShip) {
        # code...
        xDb::delete("user_network", "WHERE id = $fShip->id");
        
      }
      $state = 1;
    }
    echo json_encode($state);
  };

  $acceptance = function($request){
    $senderId  = $request->POST["sender-id"];
    $friendRequestId = $request->POST["fr-id"];
    // the current user's id is in the request object

    /**
     * create network, delete request on success
     */
    $frResult = 0;
    $networkExists = xDb::find("user_network", "*", "WHERE (user1 = $request->userid AND user2 = $senderId) OR (user2 = $request->userid AND user1 = $senderId) ");
    if(empty($networkExists)){
      $created = xDb::create("user_network", array(
        "date" => date("Y-m-d H:i:s"),
        "user1" => $request->userid,
        "user2" => $senderId
      ));
      //
      if(!empty($created)){
        // delete friend request and other possible duplicates of this request
        $frObjects = xDb::find("user_connection", "*", "WHERE sender = $senderId AND receiver = $request->userid");
        if(!empty($frObjects)){
          foreach ($frObjects as $key => $frObj) {
            xDb::delete("user_connection", "  WHERE id = $frObj->id");
          }
        }
        
        $frResult = 1;
      }


    }else{
      // delete network bcoz it's probably caused by bi-directional friend requests
      foreach ($networkExists as $key => $ne) {
        xDb::delete("user_network", "WHERE id = $ne->id ");
      }
      $frResult = -1;
    }

    // $done = xDb::update("user_connection", array(
    //   "state" => 1
    // ), "WHERE id = $friendRequestId");
    // if($done){
    //   // check wether there is network already or not
    //   $networkExists = xDb::find("user_network", "*", "WHERE (user1 = $request->userid AND user2 = $senderId) OR (user2 = $request->userid AND user1 = $senderId) ");
    //   if(empty($networkExists)){
    //     $created = xDb::create("user_network", array(
    //       "date" => date("Y-m-d H:i:s"),
    //       "user1" => $request->userid,
    //       "user2" => $senderId
    //     ));
    //     //
    //     if(!empty($created)){
    //       $frResult = 1;
    //     }
    //   }
      
    // }
    // send response
    echo $frResult;

  };
  $rejection = function($request){
    $rejected = 0;
    $friendRequestId = $request->POST["fr-id"];
    $senderId = $request->POST["sender-id"];
    // let's check whether the friend requests like this already exist
    $duplicateFrs = xDb::find("user_connection", "*", "WHERE sender = $senderId AND receiver = $request->userid");
    if(!empty($duplicateFrs)){
      if(count($duplicateFrs) > 1){
        // delete all duplicates
        foreach ($duplicateFrs as $key => $dupFr) {
          xDb::delete("user_connection", "WHERE sender = $dupFr->sender AND receiver = $dupFr->receiver");
        }
        $rejected = 1;
        
      }
      else{
        $is_success = xDb::delete("user_connection", "WHERE id = $friendRequestId");
        if($is_success){
          $rejected = 1;
        }
      }
    }
    // respond
    echo $rejected;
    
  };
     
?>