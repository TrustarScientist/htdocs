<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
    $niche = function($request, $dataset){
      // store acct to see on GET request after verifying that it is real and the niche page is loaded
      if($request->method == "GET"){
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
      $rankedNiches = xDb::find("niche", "alias", "", "ORDER BY rank DESC LIMIT 12");
      echo json_encode($rankedNiches);
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
      echo "join or leave";
  };

     
?>