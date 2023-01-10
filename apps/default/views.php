<?php
   require_once "engine/base-controllers/core.php";
   $homePage = function($request){
       render($request, "index.php");
   };
   $testerPage = function(){
        if(isset($_SESSION["user"])){
            $_SESSION["user"] = null;
            echo "<h1> TrustarScientist not logged in</h1>";
        }
        else{
            $_SESSION["user"] = 2;
            echo "<h1>Logged in as TrustarScientist </h1>";
        }
   };
   $fourOfour = function(){
       require_once "templates/404.html";
   };
   $adminMgr = function(){
       echo "<h1> ADMINISTRATION PANEL... </h1>";
   };
   $authChecker = function($request){
        if($request->is_authenticated){
            echo "1";
        }
        else{
            echo "0";
        }
   };
   $auth = function($request){
    //    if($request->is_authenticated){
    //        header("Location:/l/");
    //        exit();
    //    }
    //    else{
           render($request, "auth.html");
    //    }
   };
   $authRegister = function($request){
         if(Auth::createUser($request->POST)){
           echo "Success";
         }
         else{
           echo "error";
         }
      
   };
   $check= function($request){
    if(Auth::checker($request->POST["userC"]))
        echo json_encode(TRUE);
    else
        echo json_encode(FALSE);
   };
   $authLogin = function($request){
    if(isset($_POST['username'])&&isset($_POST['password'])){
    $LoginDetails=['username'=> sanitizer($_POST['username']),'password'=>$_POST['password'],'table'=>"acct"];
    echo json_encode(Auth::LoginAuth($LoginDetails));
    }
    else{
        echo "rare eror";
    }
   };
   $login = function($request){
       if($request->method == "POST"){
           echo "<h1>submitted</h1>";
       }
       else{
               // display the login form
               render($request, "register.html");
           }
       
   };

  
   $register = function($request){
       if($request->is_authenticated){
           // go to dashboard page if user already logged in
           header("Location:/learning/");
           exit();
       }
       else{
           if($request->method == "POST"){
               echo "blabla";
           }
           else{
               render($request ,"register.html");
           }
       }
   };
   function sanitizer($str){
    $pd= new dbconnect;
    $pdo=$pd->connect();
    $str=$pdo->quote($str);
    return htmlentities($str);
}   
?>