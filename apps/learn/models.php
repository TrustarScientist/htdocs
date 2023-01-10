<?php
    require_once "engine/base-models/models2.php";
    class Course {
        public static function get($col, $value){
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM course where $col = '$value'");
                $smt->execute();
                $result = $smt->fetch();
                return $result;
            }
            else{
                return  null;
            }
        }
        public static function getSections($course_id){
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM course_section where course = '$course_id'");
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
                return  null;
            }
        }
        public static function find($lim = "1",$table = "course"){
           
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT * FROM course limit $lim ");
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

        public static function enroll($acct_id, $course_id){
            $db  = new GnkDb();
            if($db->connected){
                $date_enrolled = date("Y-m-d");
            
                $smt = ($db->connector)->prepare("INSERT INTO course_enrolment(course, acct, `date_enrolled`) VALUES($course_id, $acct_id, $date_enrolled)");
                $result = $smt->execute();
                
                return $result;
            }
            else{
                return  null;
            }
        }

        public static function enrolmentCheck($acct_id, $course_id){
            $db  = new GnkDb();
            if($db->connected){
                $smt = ($db->connector)->prepare("SELECT DISTINCT * FROM course_enrolment where acct = '$acct_id' and course = '$course_id' ");
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