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
     
?>