<?php
    require_once "engine/base-models/models2.php";
    class Lab {
        public static function find($lim = "3",$table = "vlabs"){
           
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM vlab limit $lim ");
                $smt->execute();
                $resultSet = array();
                $counter = 0;
                while($result = $smt->fetch()){
                    $resultSet[$counter] = $result;
                    $counter += 1;
                }
                return $resultSet;
            }
            else{
                return  json_encode(array());
            }
        }
    }
?>