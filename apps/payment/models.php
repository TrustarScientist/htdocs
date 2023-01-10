<?php
    require_once "engine/base-models/models2.php";
    class Payment {
        public static function getBalance($col, $value){
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT wallet_amt FROM acct where $col = '$value' ");
                $smt->execute();
                $result = $smt->fetch();
                return $result;
            }
            else{
                return  null;
            }
        }
    }
?>