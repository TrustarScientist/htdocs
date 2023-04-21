<?php
    /**
     *  since every request controller need the 
     *   knowledge of user identity in some ways
     *  , so start session anyway
     */
    
    // import configuration settings
    require_once "engine/settings.php";

    
    class xDb{
        public $connected = false;
        public $connector = NULL; 
        public $table = "";
        function __construct(){
            try {
                //code...
                $this->connector = new PDO(DB_ENGINE.":host=".DB_HOST.";dbname=".DB_NAME, DB_USER, DB_PASS);
                $this->connector->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->connector->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);
                $this->connector->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
            
                $this->connected = true;
            } catch (\Throwable $th) {
                //log the errors in a log file
                $this->connected = false;
                if(file_exists(LOG_FILE)){
                    $handle = fopen(LOG_FILE, "a+");
                    fwrite($handle, "unable to connect to db...".date("Y-m-d H:i:s"));
                    fclose($handle);
                }
            }
        }
        public static function getCount($table, $what="*", $col="post",  $val){
            $db  = new xDb();
                if($db->connected){
                    $smt = ($db->connector)->prepare("SELECT $what FROM $table where $col = '$val' ");
                    $smt->execute();
                    $ct = 0;
                    while ($result = $smt->fetch()) {
                            $ct += 1;
                    }
                    return $ct;
                }
                else{
                    return  null;
                }
            
        }
        public static function get($table, $col, $value, $scope="*"){
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT $scope FROM $table where $col = '$value' ");
                $smt->execute();
                $result = $smt->fetch();
                return $result;
            }
            else{
                return  null;
            }
        }
        public static function trending($table, $orderCode="views", $starting="0", $amt="2"){
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM $table order by $orderCode DESC limit $starting, $amt");
                $smt->execute();
                $dataset = array();
                $ct = 0;
                while($result = $smt->fetch()){
                    $dataset[$ct] = $result;
                    $ct += 1;
                }
                return $dataset;
            }
            else{
                return  null;
            }
        }
        public static function postSearch($table, $col, $query, $starting="0", $amt="7"){
            // split query into tokens by the spacing between them
            $qTokens = explode(" ",$query);
            // build search scopes
            $scope = "SELECT * FROM $table WHERE ";    
            
            foreach ($qTokens as $word) {
                # code...
                $scope .= "$col LIKE '%$word%' OR ";
                
            }
            $finalScope = substr($scope, 0, (strlen($scope)-3)); 
         
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare($finalScope."ORDER BY date_updated DESC LIMIT $starting, $amt");
                $smt->execute();
                $dataset = array();
                $ct = 0;
                while($result = $smt->fetch()){
                    $dataset[$ct] = $result;
                    $ct += 1;
                }
                return $dataset;
            }
            else{
                return  null;
            }
        }
        public static function create($table, $col_val_array=array(), $show_error=false){
            $sql  = "INSERT INTO $table ";
            $bit1 = "( ";
            $bit2 = "  VALUES( ";
            if(!empty($col_val_array)){
                foreach ($col_val_array as $col_name => $col_val) {
                        $bit1.= "$col_name, ";
                        $bit2.= "'$col_val', ";
                }
                $bit1 = substr($bit1, 0, (strlen($bit1)-2));
                $bit2 = substr($bit2, 0, (strlen($bit2)-2));
                $bit1.= " )";
                $bit2.= " )";
                // sum up all the bits
                $sql.=$bit1;
                $sql.=$bit2;
                // attempt storage
                try {
                    //code...
                    $db = new xDb();
                    if($db->connected){
                        $smt = ($db->connector)->prepare($sql);
                        $result = $smt->execute();
                        return $result;
                    }
                    else{
                        return  null;
                    }
                } catch (\Throwable $th) {
                    //throw $th;
                    if($show_error){
                        print_r($th);
                    }
                    else{
                        return null;
                    }
                }
            }

        }
        public static function find($table, $scope="*", $cond_exp="", $orderCode="", $extras=""){
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT $scope FROM $table $cond_exp $orderCode $extras");
                $smt->execute();
                $dataset = array();
                $ct = 0;
                while($result = $smt->fetch()){
                    $dataset[$ct] = $result;
                    $ct += 1;
                }
                return $dataset;
            }
            else{
                return  null;
            }
        }
        public static function update($table, $col_val_array=array(), $cond_exp=""){
            $sql = "UPDATE $table SET ";
            if(!empty($col_val_array)){
                foreach ($col_val_array as $col => $value) {
                    # code...
                    $sql.= "$col = '$value' , ";
                    
                }
                $sql = substr($sql, 0, (strlen($sql)-2));
                $sql.= $cond_exp;
                
                // start db query uploading...
                $db  = new xDb();
                if($db->connected){
                    try {
                        //code...
                        $smt = ($db->connector)->prepare($sql);
                        $smt->execute();
                        return 1;
                    } catch (\Throwable $th) {
                        //throw $th;
                        echo json_encode($th);
                        return 0;
                    }
                }
                
            }else{
                return -1;
            }
            
        }
        public static function delete($table, $cond="0", $extras=""){
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("DELETE FROM $table $cond $extras ");
                $result = $smt->execute();
                
                return $result;
            }
            else{
                return  null;
            }
        }
        public static function save($postData){
            
            $db =  new xDb();
            if($db->connected){
                $username = "";
                $email = "";
                $password = "";
                $phone = "";
                $gender = "";
                
                if(isset($postData["username"])){
                    $username = htmlentities($postData["username"], ENT_QUOTES);
                }

                if(isset($postData["email"])){
                    $email = htmlentities($postData["email"], ENT_QUOTES);
                }
                if(isset($postData["password"])){
                    $password = htmlentities($postData["password"], ENT_QUOTES);
                }
                $hash = password_hash($password, PASSWORD_DEFAULT);
                $phone_number = "";
                if(isset($postData["phoneNumber"])){
                    $phone_number = htmlentities($postData["phoneNumber"], ENT_QUOTES);
                }
                if(isset($postData["gender"])){
                    $gender = htmlentities($postData["gender"], ENT_QUOTES);
                }
                try {
                    //code...
                  
                    $statement = ($db->connector)->prepare("INSERT INTO 
                    user(id, username, email, password, phone_number, gender)
                    VALUES(null, '$username', '$email', '$hash', '$phone_number', '$gender'); 
                    ");
                    $resultant = $statement->execute();
                    return 1;

                } catch (\Throwable $th) {
                    //throw $th;
                    return null;
                }
                 
            }
            else{
                return null;
            }
        }

        
    }
    class Data{
        // class to dynamically aggregate a set of data items
    }

    class Auth2{
        public static function loginRequired($request){
            // let's guard protected pages such as news feed, chat etc 
            if($request->is_authenticated){
                // do nothing
            }
            else{
                // redirect to anonymous home
                header("Location:/auth");
                exit();
            }
        }
        public static function createUser($postData){
            $db =  new xDb();
            if($db->connected){
                $username = "";
                $email = "";
                $password = "";
                $phone = "";
                $gender = "";
                
                if(isset($postData["usn"])){
                    $username = htmlentities($postData["usn"], ENT_QUOTES);
                }

                if(isset($postData["email"])){
                    $email = htmlentities($postData["email"], ENT_QUOTES);
                }
                if(isset($postData["pswd"])){
                    $password = htmlentities($postData["pswd"]);
                }
                $hash = password_hash($password, ENT_QUOTES);
                if(isset($postData["no"])){
                    $phone = htmlentities($postData["no"]);
                }
                if(isset($postData["gender"])){
                    $gender = htmlentities($postData["gender"]);
                }
                try {
                    //code...
                  
                    $statement = ($db->connector)->prepare("INSERT INTO 
                    user(id, username, email, password, phone_number, gender)
                    VALUES(null, '$username', '$email', '$hash', $phone, $gender); 
                    ");
                    $resultant = $statement->execute();
                    return 1;

                } catch (\Throwable $th) {
                    //throw $th;
                    return null;
                }
                 
            }
            else{
                return null;
            }
        }
        
        public static function login($idToken, $idType, $password){
            $database = new xDb();
            if($database->connected){
                // check whether the user is already logged in
                if(isset($_SESSION["user"])){
                    return -1;
                }
                else{
                    // check user login credentials
                    /**
                     *  if credentials are valid, start session and store the user id in it      
                     *  return 1 
                    */
                    $idToken = htmlentities($idToken, ENT_QUOTES);
                    $password = htmlentities($password, ENT_QUOTES);
                    // email checker
                    if($idType == "email"){

                        $statement = ($database->connector)->prepare("SELECT * FROM user WHERE email = '$idToken' ");
                        $statement->execute();
                        
                        if(!empty($acct = $statement->fetch(PDO::FETCH_OBJ))){
                            // start checking password validity
                            if(password_verify($password, $acct->pswd)){
                                // log the user in
                                $_SESSION["user"] = $acct->id;
                                return "ok";
                            }
                            else{
                                // password not correct
                                return "pnc";
                            }
    
                        }
                        else{
                            // account not found
                            return "unf";
                        }
                    }
                    // username checker
                    else if($idType == "username"){
                        // start username verification
                        $statement = ($database->connector)->prepare("SELECT * FROM user WHERE username = '$idToken' ");
                        $statement->execute();
                        if(!empty($acct = $statement->fetch(PDO::FETCH_OBJ))){
                            // start checking password validity
                            
                            if(password_verify($password, $acct->pswd)){
                                // log the user in
                                $_SESSION["user"] = $acct->id;
                                return "ok";
                            }
                            else{
                                return "pnc";
                            }
    
                        }
                        else{
                            return "unf";
                        }
                    }
                   

                }
            }
        }
        public static function  check(){
            // start session
            if(isset($_SESSION["user"])){
                return true;
            }
            else{
                return false;
            }

        }
    }
    class UserAcct{
        public static function get($col, $value){
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM acct where $col = $value ");
                $smt->execute();
                $result = $smt->fetch();
                return $result;
            }
            else{
                return  null;
            }
        }
        public static function update($col, $value, $cond, $condVal){
            $db  = new xDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("UPDATE acct SET wallet_amt = '$value' WHERE $cond = '$condVal'");
                $result = $smt->execute();
                return $result;
            }
            else{
                return  null;
            }
        }
        
    }



    
?>