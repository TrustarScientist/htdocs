<?php
   require_once "engine/base-controllers/core.php";
   require_once "models.php";

   $courses = function($request){
       //  return the courses page on GET request 
       // return list of courses on POST request as well as extract some payload data
       if($request->method  == "POST"){
            // get payload data: the starting point(starting) and limit(limit) values
            $data = "";
            if(isset($request->POST["limit"])){
                $data = Course::find($request->POST["limit"]);
                echo json_encode($data);
            }
            else{
                $data = Course::find();
                echo json_encode($data);
            }
            
       }
       else{
            render($request, "courses.html");
       }
   };
   $specificCourse = function($request, $dataset){
        //get course slug name and check db for it
        $courseSlug  = $dataset[1];
        $result = Course::get("slug", $courseSlug);
        $courseSections = array();
        if(!empty($result)){
            $courseSections = Course::getSections($result->id);
        }
        
        render($request, "course-details.php", array(
            "course_details" => $result,
            "course_sections" => $courseSections
        ));
   };
   $enrolmentChecker = function($request){
        
        $result = Course::enrolmentCheck($request->userid, $request->POST["course_id"]);
        if(empty($result)){
            echo "0";
        }
        else{
            echo "1";
        }
   };
   $enroll = function($request){
        /** this fucntion expects POST request
         * once again check whether the current user already enrolled in the course
         * if not enrolled:
         *  get the course id, price
         *  get the user id
         *  enroll the user 
         *  deduct course price from wallet balance and update wallet
         */
        if($request->method == "POST"){
            $userObject =  UserAcct::get("id", $request->userid);
            $courseObject = Course::get("id", $request->POST["course_id"]);
            if((!empty($userObject)) && (!empty($courseObject))){
                // check enrollment status
                $enrollmentStatus = Course::enrolmentCheck($userObject->id, $courseObject->id);
                if(empty($enrollmentStatus)){
                    // get course and user objects for later processing
                    $userObject = UserAcct::get("id", $request->userid);
                    $courseObject = Course::get("id", $request->POST["course_id"]);
                    if((!empty($userObject)) &&  (!empty($courseObject))){
                        // enroll user
                        $isEnrolled = Course::enroll($userObject->id, $courseObject->id);
                        if($isEnrolled){
                            // payment please!
                            $walletBalance = (int) $userObject->wallet_amt;
                            $coursePrice = (int) $courseObject->price;
                            if($walletBalance > $coursePrice){
                                $finalBalance =  $walletBalance - $coursePrice;
                                
                                // update wallet balance
                                $isPaid =  UserAcct::update("wallet_amt", $finalBalance, "id",  $userObject->id);
                                if($isPaid){
                                    echo "success";
                                }
                                else{
                                    echo "null";
                                }
                            }
                            else{
                                echo "null";
                            }

                        }
                    }
                    else{
                        echo "null";
                    }
                }
                else{
                    echo "null";
                }
                
            }
        }
   };
   $coursePrice  = function($request){
        $result =  Course::get("id", $request->POST["course_id"]);
        if(!empty($result)){
            echo $result->price;
        }
        else{
            echo "null";
        }
   };
   $learnerDash = function($request){
        if($request->method == "GET"){
            render($request, "learner-dash.php");
        }
   };
     
?>