<?php
   
    
    require_once "engine/settings.php";
    class dbconnect{
        public $pdo;
        protected $opts= [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_EMULATE_PREPARES =>false,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ];
        function connect(){
            $this->pdo= new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=utf8mb4",DB_USER,DB_PASS,$this->opts);
            return $this->pdo;
        }
        };
         function Mydate(){
            $p=new dateTime();
            $p=$p->format('Y-m-d H:i:s');
            $a=new DateTime($p);
            $a3=$a->format("Y:m:d");
            return $a3;
            }
            function checker($str){
                global $pdo;
                $que= "select * from acct where username= $str";
                $out= $pdo->query($que);
                if($out->rowCount()){
                    return TRUE;
                }
                else{
                    return FALSE;
                }
            }
       
    $pd= new dbconnect;
    $pdo= $pd->connect();
    class Auth{
        public static function createUser($postData){
            global $pdo;
            if($postData){
                $preparedStatement = $pdo->prepare('INSERT INTO `acct` (`username`, `email`, `pswd`, `phone_number`,`date_registered`) VALUES (:username, :email, :pswd, :phone_number, :date_registered)');
                $preparedStatement->execute([
                'username'       => str_replace("'", "",sanitizer($postData["user"])),
                'email'          => str_replace("'", "",sanitizer($postData["email"])),
                'pswd'  => str_replace("'", "",password_hash($postData["pwsd"], PASSWORD_DEFAULT)),
                'phone_number'   => str_replace("'", "",sanitizer($postData["number"])),
                'date_registered'=>str_replace("'",  "",Mydate()),
                ]);
                return TRUE;
            }
            else{
                return FALSE;
            }
        }
        public static function checker($str){
            global $pdo;
            $que= "select * from acct where username='$str'";
            $out= $pdo->query($que);
            if($out->rowCount()){
                return TRUE;
            }
            else{
                return FALSE;
            }
        }
        public static function LoginAuth(&$data){
            global $pdo;
            if(checker($data['username'])==TRUE){
                $Query=$pdo->query("select pswd from ".$data['table']." where username=".$data['username']);
                $Result=$Query->fetch();
                $password_hash=$Result['pswd'];
                if(password_verify($data['password'], $password_hash)){
                    $_SESSION["user"]=$data['id'];
                    return TRUE;
                }
                else
                    return FALSE;
            }
            else
                return FALSE;
        }
        public static function  check(){
            if(isset($_SESSION["user"]))
                return true;
            else
                return false;
        }
    }



    
?>