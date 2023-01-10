<?php
    require_once "engine/base-models/models2.php";
    class UserPost {
        public static function find($starting="0",$lim = "1",$table = "course"){
           
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM userpost limit $starting, $lim ");
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