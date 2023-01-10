Message = (title, body) => {
    $(".modal-title").text(title)
    $(".modal-body").text(body)
    $("#model").click()
}
$("#regform").on("submit", function(e) {
    e.preventDefault();
    if ($("[name=userR]").val() && $("[name=pswdR]").val() && $("[name=conpswdR]").val() && $("[name=numberR]").val() && $("[name=emailR]").val()) {
        if ($("[name=conpswdR]").val() != $("[name=pswdR]").val()) {
            Message("Password error", "Seems both password do not match")
        } else {
            $.ajax({
                url: "/auth4register",
                type: "POST",
                data: {
                    user: $("[name=userR]").val(),
                    pwsd: $("[name=pswdR]").val(),
                    number: $("[name=numberR]").val(),
                    email: $("[name=emailR]").val()
                },
                success: function(e) {
                    Message(e, "You Have sucessfully registered");
                    window.location.assign("/tester");
                }
            })
        }
    } else {
        Message('Error', "Completly Fill Out All Field")
    }
})

function checkerForDuplication(name) {
    if (name) {
        $.ajax({
            type: "POST",
            url: "/auth4check",
            data: { userC: name },
            success: function(e) {
                //alert(e)
                if (JSON.parse(e) == true) {
                    document.querySelector("#registerButton").disabled = true
                    $("#message").css('color', 'red').text("This user name is already used").fadeIn(1000)
                    setTimeout(() => {
                        $("#message").fadeOut(1000)
                    }, 2000)
                } else {
                    document.querySelector("#registerButton").disabled = false
                    $("#message").css('color', 'blue').text("This user name is Available").fadeIn(1000)
                    setTimeout(() => {
                        $("#message").fadeOut(1000)
                    }, 2000)
                }
            }
        })
    }
}
document.addEventListener("load", () => { checkerForDuplication($("[name=user]").val()) })
    //________________________________________________________________________
a = 0
$("#link").click(function() {
    $("#regform").toggle(1000)
    $("#loginform").toggle(1000)
    if (a == 0) {
        $("#link").text("Already have an Acount")
        $(".navbar-brand").text("Geneticks Registration Section")
        a = 1
    } else if (a == 1) {
        $("#link").text("Create a new account")
        $(".navbar-brand").text("Geneticks Login Section")
        a = 0
    }

})

$("#loginform").on("submit", function(e) {
    e.preventDefault()
    if ($('[name=user]').val() && $('[name=pswd]').val()) {
        $.ajax({
            type: "POST",
            url: "/auth4login",
            data: { username: $('[name=user]').val(), password: $('[name=pswd]').val() },
            success: function(e) {
                //alert(e)
                if (JSON.parse(e) == true) {
                    Message("Logged In", "Wellcome to geneticks computer Institute")
                } else if (JSON.parse(e) == false) {
                    Message("Oppps!!", "Username or Password is incorrect")
                } else {
                    Message("Server Down", "The server is temporarily down we are fixing this issue")
                }
            }
        })
    } else {
        Message("Blank Field", "Fill Out the Fields as required")
    }
})