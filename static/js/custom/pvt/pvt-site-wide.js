let navStateVar = 0;
$(".pvt-nav .head .commons #search-icon").click(function() {
    if (navStateVar == 0) {
        $(".pvt-nav .head .commons #profile-icon").fadeOut("slow").css("display", "none");
        $(".pvt-nav .head .brand").fadeOut("slow").css("display", "none");
        $(".pvt-nav .head #form").fadeOut("slow").css("display", "block");
        $(".pvt-nav .head .commons #search-icon").html(
            `
        <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>`
        );
        navStateVar = 1;
    } else {
        $(".pvt-nav .head .commons #profile-icon").fadeIn("slow").css("display", "initial");
        $(".pvt-nav .head .brand").fadeIn("slow").css("display", "flex");
        $(".pvt-nav .head #form").fadeOut("slow").css("display", "none");
        $(".pvt-nav .head .commons #search-icon").html(
            `
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>`
        );
        navStateVar = 0;
    }
});