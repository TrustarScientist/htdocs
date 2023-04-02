<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
    $niche = function($request, $dataset){
      // store acct to see on GET request after verifying that it is real and the niche page is loaded
      if($request->method == "GET"){
        if(!$request->is_authenticated){
            $alias = $dataset[1];
          $nicheObject = xDb::get("niche", "alias", $alias, "*");
          if(!empty($nicheObject)){
            $_SESSION["niche"] = $nicheObject->id;
            // profile page
            render($request, "niche.html");
            
          }
          else{
            // respond with 404
            header("Location:/404#nichenotfound");
            
          }
        }else{
          $alias = $dataset[1];
          $nicheObject = xDb::get("niche", "alias", $alias, "*");
          if(!empty($nicheObject)){
            $_SESSION["niche"] = $nicheObject->id;
            // profile page
            render($request, "pvt/pvt-niche.html");
            
          }
          else{
            // respond with 404
            header("Location:/404#pvt-niche-notfound");
            
          }
        }
        
      }
      else{
        // load from session if on POST request
        $nicheId = $_SESSION["niche"];
        $nicheObject = xDb::get(
          "niche",  
          "id",
          $nicheId,
          "*"
        );
        // get parent niche alias
        $parent = xDb::get("niche", "id", $nicheObject->parent, "alias");
        $nicheObject->parent_alias = "";
        if(!empty($parent)){
          $nicheObject->parent_alias = $parent->alias;
        }
        // membership count
        $nicheObject->members = xDb::getCount("niche_membership", "*", "niche", $nicheObject->id);
        $nicheObject->posts = xDb::getCount("post", "*", "category", $nicheObject->id);
        echo json_encode($nicheObject);
      }
      
    };

    $topRank = function($request){
      // get the total number of niches
      $tmpNiches = xDb::find("niche");
      $total = count($tmpNiches);
      // pick random number for starting position. It must not be more than half of the total
      $random = rand(1, $total);
      $rankedNiches = xDb::find("niche", "alias", "", "ORDER BY rank DESC LIMIT $random,  $total");
      shuffle($rankedNiches);
      if(count($rankedNiches) > 15){
        echo json_encode(array_slice($rankedNiches, 0, 12));
      }else if(count($rankedNiches) < 15){
        echo json_encode($rankedNiches);
      }else{
        echo json_encode(array_slice($tmpNiches, 0, 12));
      }
      
    };
    
  $nichePosts = function($request){
    // profile gotten from POST request body
    $nicheId = 0;
    $starting = 0;
    $amount = 1;
    if((isset($request->POST["niche_id"])) && (isset($request->POST["amount"])) && (isset($request->POST["starting"]))){
      $nicheId = $request->POST["niche_id"];
      $starting = $request->POST["starting"];
      $amount = $request->POST["amount"];
    }
    $profilePosts = xDb::find("post", "*", "where category = '$nicheId'", "ORDER BY date_updated DESC", "limit $starting, $amount");
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
                    $nicheObj = "";
                    if(!empty($data->poster)){
                        $userObj = xDb::get("user", "id", $data->poster, "id, username");
                        if(!empty($userObj)){
                            $post["user"] = $userObj;
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
  $joinOrLeave = function($request){
      $responseState = 0;
      // if the acct-id property is not specified, it defaults to current user id
      $acctId = (isset($request->POST["member-id"]))? $request->POST["member-id"]: $request->userid;
      $nicheId = $request->POST["niche-id"];
      /**
       *  if 'toggle is true, change the state of the request . For example, if the user is already a member, delete membership 
       *  record btwn the acct & niche and vice versa
       *  if it is false, just return the membership state...whether a member or not
       */
      $toggle = (isset($request->POST["toggle"]))? $request->POST["toggle"]:1;
      if($toggle == 0){
        // just check wether the current user is a member or not
        $mState = xDb::find("niche_membership", "*", " WHERE member = $acctId AND niche = $nicheId ");
        if(!empty($mState)){
          echo "am"; // is member
        }else{
          echo "nam"; // is NOT a member
        }





      }else{
          /**
         *  if acct is already a member delete membership else do otherwise
         */
      
      
        $memberships = xDb::find("niche_membership", "*", " WHERE member = $acctId AND niche = $nicheId ");
        if(empty($memberships)){
          // create membership record
          xDb::create("niche_membership", array(
            "member" => $acctId,
            "niche" => $nicheId,
            "date" => date("Y-m-d")
          ));
          $responseState = 1;
        }else{
          // delete membership record...and other posible duplicates
          foreach ($memberships as $key => $membership) {
            xDb::delete("niche_membership", "WHERE member = $acctId AND niche = $nicheId");
          }
          $responseState = 0;
        }
        // respond
        echo $responseState;
      }
      
  };

     
?>