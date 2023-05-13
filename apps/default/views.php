<?php
   require_once "engine/base-controllers/core.php";
   require_once "engine/base-controllers/core2.php";
    require_once "engine/base-models/models2.php";
    
  
   $homePage = function($request){
       if($request->is_authenticated){
            header("Location:/newsfeed");
       }
       else{
            render($request, "index.html");
       }
   };
   $questSearch = function($request){
    
   };
   
    /** website info */
    $wsInfo = function($request){
        $users = count(xDb::find("user", "id"));
        $posts = count(xDb::find("post", "id"));
        $niches = count(xDb::find("niche", "id"));
        echo json_encode(array(
            "users" => $users,
            "posts" => $posts,
            "niches" => $niches
        ));
    };
    $contentTypeSearch = function($request){
        // get post content type id
        $type = strtolower($request->POST["ct"]);
        $starting = $request->POST["starting"];
        $amount = $request->POST["amount"];

        $typeId = (xDb::get("contenttype",  "name", $type))->id;

        $typedPosts = xDb::find("post", "*", " where    content_type = $typeId", "", "LIMIT $starting, $amount");
        $aggregatePosts = array();
        $postTemplate2 = array();
        $ct22 = 0;
        foreach($typedPosts as $rPost) {
            $postTemplate2["poster_blocked"] = false;
            $postTemplate2["cuser_is_member"] = false;
            $postTemplate2["contenttype"] = (xDb::get("contenttype", "id", $rPost->content_type))->name;
            $postTemplate2["postid"] = $rPost->id;
            $postTemplate2["title"] = $rPost->title;
            $postTemplate2["slug"] = $rPost->slug;
            $postTemplate2["content"] = $rPost->content;
            $postTemplate2["updated"] = date("Y-M-d",strtotime($rPost->date_updated));
            $postTemplate2["views"] = $rPost->views;
            // user who created
            $postTemplate2["user"] = "";
            $postTemplate2["own"] = 0;
            
            $userObj = "";
            // niche categorized in
            $postTemplate2["niche"] = "";
            $nicheObj = "";
            if(!empty($rPost->poster)){
                $userObj = xDb::get("user", "id", $rPost->poster, "id, username, photo");
                if(!empty($userObj)){
                    $postTemplate2["user"] = $userObj;
                }
            }
            if(!empty($rPost->category)){
                $nicheObj = xDb::get("niche", "id", $rPost->category, "id, alias");
                if(!empty($nicheObj)){
                    $postTemplate2["niche"] = $nicheObj;
                }
            }
            $postTemplate2["pic"] = "";
            $postPic2 = xDb::get("editor_post_image", "post", $rPost->id, "path");
            if(!empty($postPic2)){
                $postTemplate2["pic"] = $postPic2->path;
            }
            //stats
            $postTemplate2["following"] = xDb::getCount("post_followership", "*", "post", $rPost->id);
            $postTemplate2["comments"] = xDb::getCount("post_comment", "*", "post", $rPost->id);
            // check whether d current user has followed this post or not
            $postTemplate2["c_user_has_followed"] = 0;
            $postTemplate2["c_user_has_followed"] = count(xDb::find("post_followership", "*", "WHERE post = $rPost->id AND follower = -1"));
            // aggregate
            $aggregatePosts[$ct22] = $postTemplate2;
            $ct22 += 1;
        }

        echo json_encode($aggregatePosts);
    };
   $searchEngine = function($request){
    if(($request->method == "GET") && (!$request->is_authenticated)){
        render($request, "search.html");
    }else if(($request->method == "GET") && ($request->is_authenticated)){
        render($request, "pvt/pvt-search.html");
    }else if(($request->method == "POST") && (!$request->is_authenticated)){
        echo "post request for public pages";
    }else if(($request->method == "POST") && ($request->is_authenticated)){
        $userId = $request->userid;
        $query = $request->POST["query"];
        $type = $request->POST["type"];
        $starting =  $request->POST["starting"];
        $amount = $request->POST["amount"];
        switch ($type) {
            case 'person':
                $resultPeople = xDb::fulltextSearch("id, username, photo", "user", $query, "username, first_name, last_name, work_info, school_info, intro, hobbies", $starting, $amount);
                echo json_encode($resultPeople);
                break;
            case 'post':
                $resultPosts = xDb::fulltextSearch("*", "post", $query, "title, content", $starting, $amount);
                // posts aggregation
                $rpostsAggr = array();
                // aggregate data
                $postTemplate = array();
                $ct2 = 0;
                    
                foreach($resultPosts as $rPost) {
                    $postTemplate["poster_blocked"] = false;
                    $blacklist = xDb::find("user_blacklist", "*", "WHERE blocked = $rPost->poster AND blocker = $userId");
                    if(!empty($blacklist)){
                        $postTemplate["poster_blocked"] = true;
                    }
                    $postTemplate["cuser_is_member"] = false;
                    $membership = xDb::find("niche_membership", "*", "WHERE niche = $rPost->category AND member = $userId");
                    if(!empty($membership)){
                        $postTemplate["cuser_is_member"] = true;
                    }
                    $postTemplate["contenttype"] = (xDb::get("contenttype", "id", $rPost->content_type))->name;
                    $postTemplate["postid"] = $rPost->id;
                    $postTemplate["title"] = $rPost->title;
                    $postTemplate["slug"] = $rPost->slug;
                    $postTemplate["content"] = $rPost->content;
                    $postTemplate["updated"] = date("Y-M-d",strtotime($rPost->date_updated));
                    $postTemplate["views"] = $rPost->views;
                    // user who created
                    $postTemplate["user"] = "";
                    $postTemplate["own"] = 0;
                    if($userId == $rPost->poster){
                        $postTemplate["own"] = 1;
                    }
                    $userObj = "";
                    // niche categorized in
                    $postTemplate["niche"] = "";
                    $nicheObj = "";
                    if(!empty($rPost->poster)){
                        $userObj = xDb::get("user", "id", $rPost->poster, "id, username, photo");
                        if(!empty($userObj)){
                            $postTemplate["user"] = $userObj;
                        }
                    }
                    if(!empty($rPost->category)){
                        $nicheObj = xDb::get("niche", "id", $rPost->category, "id, alias");
                        if(!empty($nicheObj)){
                            $postTemplate["niche"] = $nicheObj;
                        }
                    }
                    $postTemplate["pic"] = "";
                    $postPic2 = xDb::get("editor_post_image", "post", $rPost->id, "path");
                    if(!empty($postPic2)){
                        $postTemplate["pic"] = $postPic2->path;
                    }
                    //stats
                    $postTemplate["following"] = xDb::getCount("post_followership", "*", "post", $rPost->id);
                    $postTemplate["comments"] = xDb::getCount("post_comment", "*", "post", $rPost->id);
                    // check whether d current user has followed this post or not
                    $postTemplate["c_user_has_followed"] = 0;
                    $postTemplate["c_user_has_followed"] = count(xDb::find("post_followership", "*", "WHERE post = $rPost->id AND follower = $userId"));
                    // aggregate
                    $rpostsAggr[$ct2] = $postTemplate;
                    $ct2 += 1;
                }

                echo json_encode($rpostsAggr);
                break;
            case 'niche':
                $rnData = array();
                $resultNiches = xDb::fulltextSearch("*", "niche", $query, "name, alias, description", $starting, $amount);
                foreach ($resultNiches as $key => $resultNiche) {
                    // check wether  the current user is a member or not
                    $resultNiche->cuser_is_member = false;
                    $cUserMembership = xDb::find("niche_membership", "*", "WHERE member = $request->userid AND niche = $resultNiche->id");
                    if(!empty($cUserMembership)){
                        $resultNiche->cuser_is_member = true;
                    }
                    // members count
                    $resultNiche->members = xDb::getCount("niche_membership", "*", "niche", $resultNiche->id);
                    // posts count
                    $resultNiche->posts = xDb::getCount("post", "*", "category", $resultNiche->id);
                    array_push($rnData, $resultNiche);
                }
                echo json_encode($rnData);
                break;
                

            default:
                # code...
                break;
        }

    }
    
};


$about = function($request){
    render($request, "about.html");
};
    $logout = function($request){
        $_SESSION["user"] = null;
        header("Location:/");
    };
   $newsfeed = function($request){
        if($request->is_authenticated){
            render($request, "pvt/newsfeed.html");
        }
        else{
            header("Location:/login");
        }
   };
   $login = function($request){
        if(($request->method == "GET")){
            render($request, "login.html");
        }
        
        else{
            $responseData = array();
            $responseData["state"] = 0;
            $responseData["id_token_error"] = "";
            $responseData["password_error"] = "";
            // start processing
            $id_token = "";
            $password = "";
            $id_token = $_POST["u_e_pn"];
            // trim token 
            $id_token = trim($id_token);
            $password = $_POST["password"];
            
            $id_type = identifyer($id_token);
            
            switch ($id_type) {
                case 'username':
                    # code...
                    $userObject = xDb::get("user", "username", $id_token);
                    if(!empty($userObject)){
                
                        if(password_verify($password, $userObject->password)){
                            $responseData["state"] = 1;
                            $_SESSION["user"] = $userObject->id;
                        }
                        else{
                            $responseData["password_error"] = "Password Incorrect";
                        }
                    }
                    else{
                        $responseData["id_token_error"] = "Username Unknown";
                    }
                    break;
                    case 'email':
                        # code...
                        $userObject = xDb::get("user", "email", $id_token);
                        if(!empty($userObject)){
                    
                            if(password_verify($password, $userObject->password)){
                                $responseData["state"] = 1;
                                $_SESSION["user"] = $userObject->id;
                            }
                            else{
                                $responseData["password_error"] = "Password Incorrect";
                            }
                        }
                        else{
                            $responseData["id_token_error"] = "Email Unknown";
                        }
                        break;
                        case 'number':
                            # code...
                            $userObject = xDb::get("user", "phone_number", $id_token);
                            if(!empty($userObject)){
                        
                                if(password_verify($password, $userObject->password)){
                                    $responseData["state"] = 1;
                                    $_SESSION["user"] = $userObject->id;
                                }
                                else{
                                    $responseData["password_error"] = "Password Incorrect";
                                }
                            }
                            else{
                                $responseData["id_token_error"] = "Phone Number Unknown";
                            }
                            break;
                        
                default:
                    # code...
                    break;
            }
            // respond
            echo json_encode($responseData);
        }
   };
   
   $register = function($request){
        if($request->method == "GET"){
            render($request, "register.html");
        }
        else{
            $responseData = array();
            $responseData["state"] = 0;
            $responseData["error"] = "";
            // start processing
            // first check whether the username is unique
            $username = "";
            if(isset($_POST["username"])){
                $username = $_POST["username"];
                if((xDb::getCount("user", "username", "username", $username)) > 0){
                    $responseData["state"] = 0;
                    $responseData["error"] = "Username Already Exists";
                }
                else{
                    // store credentials accordingly
                    $result = xDb::save($_POST);
                    
                    if(!empty($result)){
                        $responseData["state"] = 1;
                        // let the new account be a member of the default niche : @worldwide
                        
                    }
                    else{
                        $responseData["error"] = "Something went wrong...try again later";
                    }
    
                }
            }
            
            // ultimately return response
            echo json_encode($responseData);
        }
   };
   $fourZeroFour = function(){
       require_once "templates/404.html";
   };
   
    
?>