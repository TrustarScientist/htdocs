$(document).ready(function() {


    // reference all form values
    let loginForm = document.querySelector(".form");
    $(".sbt-btn").click(function(e) {
        e.preventDefault();
        // send form data
        let idToken = $('.form input[name="idtoken"]').val();
        let pswd = $('.form input[name="pswd"]').val();
        let lData = {
            "idtoken": idToken,
            "pswd": pswd
        };
        $.post("/login", lData, function(data, status) {
            // get display elements and convert json
            let resData = JSON.parse(data);
            $("#status").text(resData.status);
            $("#unf").text(resData.unf_error);
            $("#pnc").text(resData.pnc_error);
            // redirect on success
            if (resData.status !== "") {
                setTimeout(function() {
                    location.assign("/post/personalized");
                }, 2000);
            }
        });
    });
});