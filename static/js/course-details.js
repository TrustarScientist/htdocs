$(".other-courses").click(function() {
    $(".c-con").fadeToggle("slow");
});
// fetch course details

// payment and enrolment code
/**
 * when the 'enrol button` is clicked, an ajax request to check whether the user is logged in or not is sent
 * if the user is not logged in:
 *      store the course id in 'cart' session  so that the user can continue payment on logging in
 *      display an info board telling the user to login
 * else if logged in:
 *      check wether the user already enrolled in the course
 *      if not enrolled:
 *          get wallet balance and dispaly balance
 *          if wallet balance is more than course price:
 *              display payment confirmation box and deduct from wallet on click
 *          else:
 *              don't display confirmation box
 *              show that wallet balance not enough
 *     
 */
$("#enrolment-btn").click(function(e) {
    let courseId = e.target.dataset.id;
    $.get("/authcheck", function(data, status) {
        if (data == "0") {
            $(".login-needed").fadeIn("slow").css("display", "block");
        } else if (data == "1") {
            // check enrolment status...display state

            $.post("/learn/enrolment_check", {
                "course_id": courseId
            }, function(data, status) {
                if (data == "1") {
                    $("#enrolment-btn").text("You have enrolled already...");
                } else if (data == "0") {
                    // get wallet balance...the backend should check the logged in user in session or return null
                    $.get("/payment/balance", function(data, status) {
                        let walletAmount = 0;
                        if (data == "null") {
                            $("#enrolment-btn").text("Something went wrong...reload page");
                        } else {
                            let walletAmount = Number(data);
                            // display wallet and confirmation info box
                            $(".payment-info-box .balance").text(walletAmount);
                            $(".payment-info-box").fadeIn("slow").css("display", "block");
                            //check course price
                            $.post("/learn/courseprice", { "course_id": courseId }, function(data, status) {

                                if (data != "null") {
                                    //  check whether the walletAmount is more than the course price
                                    let coursePrice = Number(data);

                                    if (walletAmount < coursePrice) {
                                        $(".payment-info-box .top-up-btn").fadeIn("slow").css("display", "inline");
                                    } else {
                                        $(".payment-info-box .confirmation-btn").fadeIn("slow").css("display", "inline");
                                        // listen to the cofirmation button
                                        // onclick...enrol and deduct from wallet of current user
                                        $(".payment-info-box .confirmation-btn").click(function() {
                                            $.post("/learn/enroll", { "course_id": courseId }, function(data, status) {

                                                if (data == "success") {
                                                    $(".payment-info-box .confirmation-btn").html("Successfully enrolled...<a class='btn btn-primary' href='/learn/dashboard'>start learning right way</a>");
                                                } else {
                                                    $(".payment-info-box .confirmation-btn").text("Something went wrong...sorry`");
                                                }
                                            });
                                        });
                                    }
                                }
                            });



                        }
                    });
                }
            });
        }
    });
});