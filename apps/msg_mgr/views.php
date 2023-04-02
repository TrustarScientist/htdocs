<?php
   require_once "engine/base-controllers/core.php";
    require_once "engine/base-models/models2.php";
    require_once "engine/base-models/models.php";
    
    // show messages page if authenticated...
    $inbox = function($request){
      if($request->is_authenticated){
        // render page on GET request
        if($request->method == "GET"){
          render($request, "pvt/pvt-msg.html");
        }else{
          // return json data on POST request...latest messages
          $messages = xDb::find("user_msg", "*", "WHERE receiver = $request->userid AND sender != $request->userid AND `is_read` = '0' ", "ORDER BY datetime DESC", "LIMIT 0, 1000");
          if(!empty($messages)){
          // add related data
            foreach ($messages as $key => $msg) {
              $msg->sender = xDb::get("user", "id", $msg->sender, "id, username, photo");
              $msg->pretty_date = date("Y-M-d h:i A",strtotime($msg->datetime));
            }
            
          }
          echo json_encode($messages);
        }
        
      }
      else{
        // show login page
        header("Location:/login#login-required");
      }
    };
    // fetch unread messages...ordered by their date...from the latest to the oldest
    $getLatestMessages = function($request){
      // last message  fetched's date is required so that we don't weary th DB ENGINE
      $endingMsgDate = $request->POST["LMT"];
      $latestMessages = xDb::find("user_msg", "*", "WHERE receiver = '$request->userid' AND is_read = '0' AND datetime > '$endingMsgDate' ", "ORDER BY datetime DESC", "LIMIT 25");
      if(!empty($latestMessages)){
        foreach ($latestMessages as $key => $laMsg) {
          $laMsg->sender =  xDb::get("user", "id", $laMsg->sender, "id, username, photo");
          $laMsg->pretty_date = date("Y-M-d h:i A",strtotime($laMsg->datetime));
          $laMsg->aside = $endingMsgDate;
        }
      }
      echo json_encode($latestMessages);
    };

    $conversation = function($request){
      // conversations from last session

    };
    

    $addMessage = function($request){
      $response = 0;
      $sender = $request->userid;
      $receiver = $request->POST["to"];
      $body = htmlentities(addslashes($request->POST["body"]));
      $datetime = date("Y-m-d H:i:s");

      if(($sender != $receiver) && ($body != "")){
        $created = xDb::create("user_msg", array(
          "sender" => $sender,
          "receiver" => $receiver,
          "datetime" => $datetime,
          "body" => $body                  
        ), true);
      }
      $response = 1;

      echo $response;
    };


    // $returnfriends = function($request){
    //   global $pdo;
    //   $arr_user_id=[];
    //   $array_of_friends_id= [];
    //   $user_id= $request->userid;
    //   $query_string= "select sender, receiver from user_connection where state=1 and sender= '$user_id' or state=1 and receiver= '$user_id'";
    //   $query=$pdo->query($query_string);
    //   while($eachOut=$query->fetch()){
    //     if($eachOut["sender"]!== $user_id){
    //       array_push($array_of_friends_id, $eachOut["sender"]);
    //     }
    //     elseif($eachOut["receiver"]!== $user_id){
    //       array_push($array_of_friends_id, $eachOut["receiver"]);
    //     }
    //   }
    //   for($a=0; $a< count($array_of_friends_id); $a++){
    //     $dbdata=$pdo->query("select username,id from user where id=$array_of_friends_id[$a]");
    //     array_push($arr_user_id,$dbdata->fetchAll()[0]);
    //   }
    //  $datapassed=[$arr_user_id, $_SESSION["user"]];
    //   echo(json_encode($datapassed));
    // };
    // $getChats= function($request){
    //   global $pdo;
    //   $pos= $request->POST["pos"];
    //   $reciever= $request->POST["receiver"];
    //   $sender= $request->userid;
    //   $countData=$pdo->query("select count(*) from user_msg where receiver=$reciever[0] and sender= $sender or sender=$reciever[0] and receiver= $sender"); 
    //   $fetchCount=$countData->fetch();
    //   $realCount=$fetchCount["count(*)"];
    //   $count=$realCount- $pos;
    //   if($count> 7){
    //     $inner_count = $count-7;
    //     $query=$pdo->query("select receiver, sender, body, id, 'read' from user_msg where receiver=$reciever[0] and sender= $sender or sender=$reciever[0] and receiver= $sender  order by id  asc limit $inner_count, 7 ");
    //     $fetchAll= $query->fetchAll();
    //     echo(json_encode([$fetchAll,$realCount,FALSE]));
    //   }
    //   elseif($count<= 7){
    //     $query=$pdo->query("select receiver, sender, body, id, 'read' from user_msg where receiver=$reciever[0] and sender= $sender or sender=$reciever[0] and receiver= $sender  order by id  asc limit $count");
    //     $fetchAll= $query->fetchAll();
    //     echo(json_encode([$fetchAll,$realCount, TRUE]));
    //   }
    // };
    // $loaded= [];
    // function Read($id){
    //   global $pdo;
    //   foreach ($id as $key => $value) {
    //   $countData=$pdo->query("update user_msg set read='true' where id= $value");
    //   array_push($value, $loaded);
    //   }
    // }
    // $constantChecking= function($request){
    //   global $pdo;
    //   global $count;
    //   $reciever= $request->POST["receiver"];
    //   $sender= $request->userid;
    //   $countData=$pdo->query("select count(*) from user_msg where receiver=$reciever[0] and sender= $sender or sender=$reciever[0] and receiver= $sender"); 
    //   $fetchCount=$countData->fetch();
    //   $count=$fetchCount["count(*)"];
    //   $formalCount= $request->POST["state"];
    //   $countDifference=$count-$formalCount;
    //   if($countDifference > 0){
    //     $query=$pdo->query("select receiver, sender, body, id from user_msg where receiver=$reciever[0] and sender= $sender or sender=$reciever[0] and receiver= $sender order by id  desc limit $countDifference");
    //     $fetchAll= $query->fetchAll();
    //     echo(json_encode([$fetchAll,$count]));
    //   }
    //   else{
    //     echo("zeroState");
    //   }
    // };
    //   $getFriends= function($request){
    //     global $pdo;
    //     $userId           =$_SESSION["user"];
    //     $username_id_array=[];
    //     $listOfFriends    =[];
    //     $query_string     ="select id, username from user order by id  desc limit 5";
    //     $query            =$pdo->query($query_string);
    //     $query_string1    ="select sender,receiver from `user_connection` where sender='$userId' or receiver='$userId'";
    //     $query1           =$pdo->query($query_string1);
    //     while($eachOut=$query1->fetch()){
    //         $eachOut["sender"] == $userId ? array_push($listOfFriends,$eachOut["receiver"]) : array_push($listOfFriends,$eachOut["sender"]);
    //         }
    //     while ($eachOut= $query->fetch()){
    //       if( $eachOut["id"]!=$userId)
    //           in_array($eachOut["id"],$listOfFriends) ? null : array_push($username_id_array,[$eachOut["username"], $eachOut["id"]]);
    //     }
    //     echo (json_encode([$username_id_array, $userId]));
    //   };
    //   $friendRequestResponse= function($request){
    //     global $pdo;
    //     $friend_id= $request->POST["friend"];
    //     $user_id= $request->userid;
    //     $reponse= json_decode($request->POST["response"]);
    //     if($reponse){
    //          $query_string= "update user_connection set state= 1 where sender=$friend_id[0] and receiver=$user_id";
    //     }
    //     else{
    //       $query_string= "delete from user_connection where sender=$friend_id[0] and receiver=$user_id";
    //     }
    //     $pdo->query($query_string);
    //   };
    //   $getFriendRequest= function($request){
    //     global $pdo;
    //     $friend_request_array=[];
    //     $user_session =$_SESSION['user'];
    //    $query_string  = "select sender from user_connection where receiver= $user_session and state= 0";
    //    $query         =$pdo->query($query_string);
    //    while($eachOut = $query->fetch()){
    //     $id_of_sender          = $eachOut["sender"];
    //     $each_query_string     ="select id, username from user where id=$id_of_sender";
    //     $each_query            = $pdo->query($each_query_string);
    //     array_push($friend_request_array,$each_query->fetchAll()[0]);
    //    }

    //    echo(json_encode([$friend_request_array, $request->userid]));
    //   };
    //   $sendRequest   = function($request){
    //     global $pdo;
    //     $user_id     =$request->userid;
    //     $friend_id   =$request->POST["friendId"];
    //     $date        = $request->POST["date"];
    //     try{
    //       $query_string= "insert into user_connection(sender, receiver, date, state) value($user_id, $friend_id[0], $date[0], 0)";
    //       $pdo->query($query_string);
    //       echo(json_encode(TRUE));
    //     } catch (\Throwable $th) {
    //      echo(json_encode(FALSE));
    //     }
    //   };
    //   function sanitizer($str){
    //     global $pdo;
    //     $str=$pdo->quote($str);
    //     return htmlentities($str);
    // }
    //   $insertChat= function($request){
    //     global $pdo;
    //     $receiver=$request->POST["receiver"];
    //     $sender=$request->userid;
    //     $message=sanitizer($request->POST["message"]);
    //     $pdo->query("insert into user_msg(sender,receiver,body) value($sender, $receiver[0],".$message.")");
    //     // echo($message);
    // };
    
     
?>