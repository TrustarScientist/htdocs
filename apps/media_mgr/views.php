<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
  $post_media = function($request, $dataset){
    $type = $dataset[1];
    $name = $dataset[2];
    echo file_get_contents("mediafiles/$type/$name");
  };
  $niche = function($request, $nicheAlias){
    if($request->method == "GET"){
      $_SESSION["pvt"] = "done";
    print_r($_SESSION);
    }
    else{
      print_r($_SESSION);
    }
  };
     
?>