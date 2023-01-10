<?php
   require_once "engine/base-controllers/core.php";
   require_once "models.php";

   $userposts = function($request){
       //  return the courses page on GET request 
       // return list of courses on POST request as well as extract some payload data
       if($request->method  == "POST"){
            // get payload data: the starting point(starting) and limit(limit) values
            $data = "";
            if((isset($request->POST["limit"])) && (isset($request->POST["limit"]))){
                $data = UserPost::find($request->POST["limit"]);
                echo json_encode($data);
            }
            else{
                $data = UserPost::find();
                echo json_encode($data);
            }
            
       }
       else{
            render($request, "userposts.html");
       }
   };
     
?>