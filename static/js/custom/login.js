let form = document.querySelector(".logform");
form.addEventListener("submit", function(e) {
    e.preventDefault();
    let username = $(".logform #usn").val();
    let password = $(".logform #pswd").val();
    let dataset = {
        "u_e_pn": username,
        "password": password
    };
    $.post("/login", dataset, function(data, status) {
        //alert(data);
        //convert json to Js object
        let responseData = JSON.parse(data);
        if (responseData != {}) {
            // check authentication state
            if (responseData.state == 1) {
                // display state and redirect to newsfeed page
                $(".as").text("Successfully logged in...").fadeIn();
                setTimeout(function() {
                    window.location.assign("/");
                }, 1000);
            } else {
                // display errors
                $(".ad").html(responseData.id_token_error + " " + responseData.password_error).fadeIn("fast", function(e) {
                    setTimeout(function(e) { $(".ad").fadeOut(); }, 1000);
                });

            }
        } else {
            alert("Could not fetch authentication state...");
        }
    });
});