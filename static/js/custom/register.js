let form = document.querySelector(".regform");
form.addEventListener("submit", function(e) {
    e.preventDefault();
    let dataset = {
        username: $(".regform #usn").val(),
        email: $(".regform #email").val(),
        password: $(".regform #pswd").val(),
        phoneNumber: $(".regform #no").val(),
        gender: $(".regform #gender").val(),
    };
    let username = $(".regform #usn").val();
    let email = $(".regform #email").val();
    let password = $(".regform #pswd").val();
    let phoneNumber = $(".regform #no").val();
    let gender = $(".regform #gender").val();
    // aler containers
    let successAd = document.querySelector(".regform .as");
    let dangerAd = document.querySelector(".regform .ad");
    $.post("/register", dataset, function(data, status) {
        //alert(data);
        let res = JSON.parse(data);
        if (res.state == 1) {
            // success
            successAd.style.display = "block";
            dangerAd.style.display = "none";
            // redirect to login after 1 sec
            setTimeout(function() {
                window.location.assign("/login");
            }, 1000);
        } else {
            successAd.style.display = "none";
            dangerAd.style.display = "block";
            dangerAd.textContent = res.error;

        }
    });
});