<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
  $media = function($request){
    echo "<h1> POst Media</h1>";
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
                echo json_encode(array());
            }
            
       }
   };
   

    
?>