<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    
  
   $latest = function($request){
       if($request->method == "POST"){
            $dataset = xDb::findLatest("post");
            if(!empty($dataset)){
                echo json_encode($dataset);
            }
            else{
                echo json_encode(array());
            }
            
       }
   };
   

    
?>