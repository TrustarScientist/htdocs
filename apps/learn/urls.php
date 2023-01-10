<?php
  include_once "views.php";
    $urlpatterns = [
        "/^courses$/" => $courses,
        "/^course\/([-\w]+)$/" => $specificCourse,
        "/^enrolment_check$/" => $enrolmentChecker,
        "/^courseprice$/" =>  $coursePrice,
        "/^enroll$/" => $enroll,
        "/^dashboard$/" => $learnerDash,
    ];

?>