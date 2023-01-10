$(document).ready(function() {
    // form 
    // submit button controller
    let submitBtn = document.querySelector(".sbt-btn");
    submitBtn.addEventListener("click", function(e) {
        // prevent default browser execution
        e.preventDefault();
        // validate input data...don't stress the server too much

        // prepare form for server-side check
        let newUsername = $('.form input[name="usn"]').val();
        let newEmail = $('.form input[name="eml"]').val();
        let newPassword = $('.form input[name="pswd"]').val();
        let data2server = {
            usn: newUsername,
            eml: newEmail,
            pswd: newPassword
        };
        // ajax post request
        $.post("/signup", data2server, function(data, status) {
            //get all error display elements
            // convert json to js object
            let rData = JSON.parse(data);
            $(".usn-info").text(rData.usn_error);
            if (rData.usn_error == "") {
                if (rData.registered == 0) {
                    // something went wrong..show it
                    $(".bad-screen").text("Somthing Went wrong...try again later");
                    $(".good-screen").text("");
                } else {
                    $(".bad-screen").text("");
                    $(".good-screen").text("Sucessfully registered");
                    // redirect to newsfeed page
                    setTimeout(function() {
                        location.assign("/login");
                    }, 2000)
                }
            }


        });
    });



});