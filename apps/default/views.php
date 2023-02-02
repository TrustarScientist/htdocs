<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
  
   $homePage = function($request){
       render($request, "index.html");
   };
   $login = function($request){
        echo "<h1> You little...";
   };
   $searchEngine = function($request){
        render($request, "search.html");
   };
   $fourZeroFour = function(){
       require_once "templates/404.html";
   };

    
?>