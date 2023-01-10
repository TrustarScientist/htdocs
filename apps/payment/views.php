<?php
   require_once "engine/base-controllers/core.php";
   require_once "models.php";

   $balance = function($request){
        $result = Payment::getBalance("id", $request->userid);
        if(empty($result)){
            echo "null"; // perhaps user credentials not correct or db error
        }
        else{
            echo $result->wallet_amt;
        }
   };
     
?>