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
   $connections = function($request){
    render($request, "pvt/connections.html");
   };
   $searchEngine = function($request){
    if($request->method == "GET"){
        if(!$request->is_authenticated){
            // query has to be sent but content type is optional
           if(isset($_GET["query"])){
                $_SESSION["query"] = trim($_GET["query"]);
           }
           else{
            $_SESSION["query"] = "";
           }
           // content type part
            if(isset($_GET["ct"])){
                $_SESSION["ct"] = trim($_GET["ct"]);
            }
            else{
                $_SESSION["ct"] = "";
            }
            render($request, "search.html");
            
        }
    }
    else{
        
        // get search result thru POST request
        if(!$request->is_authenticated){
            $query = "";
            $ct = "";
            if(isset($_SESSION["query"])){
                $query = $_SESSION["query"];
            }
            if(isset($_SESSION["ct"])){
                $ct = (int) $_SESSION["ct"];
            }
            
            $starting = "";
            if(isset($request->POST["starting"])){
                $starting = $request->POST["starting"];
            }
            $amount = "";
            if(isset($request->POST["amount"])){
                $amount = $request->POST["amount"];
            }
            // search database
            $searchResults = xDb::postSearch("post", "title", $query, $starting, $amount);
            // add  more info related to results
        
            $responseData =  array();
            $pos = 0;
            $post = array();
            if(!empty($searchResults)){
                
                foreach ($searchResults as  $data) {
                    # code...
                    $post["postid"] = $data->id;
                    $post["title"] = $data->title;
                    $post["slug"] = $data->slug;
                    $post["content"] = $data->content;
                    $post["updated"] = date("Y-M-d h:i A",strtotime($data->date_updated));
                    $post["views"] = $data->views;
                    $post["query"] = $query;
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
                    $responseData[$pos] = $post;
                    $pos += 1;
                }
            }
            echo json_encode($responseData);
            
            
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