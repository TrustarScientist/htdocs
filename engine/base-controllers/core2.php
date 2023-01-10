<?php
     // id token type checker
     function identifyer($data){
        if(filter_var($data, FILTER_VALIDATE_EMAIL)){
            $result =  "email" ;
        }
       
        else{
            $result = "username";
        }
        // anyway...return the data
        return $result;
        
    }


?>