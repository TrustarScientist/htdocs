$(".mission").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139,77)";
    $(".discussions").css("border-bottom", "0");
    $(".members").css("border-bottom", "0")
        //
    $(".niche-posts-section").css("display", "none");
    $(".rp-container").css("display", "none");
    $(".mission-statement").fadeIn("fast");

})

$(".discussions").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139,77)";
    $(".members").css("border-bottom", "0");
    $(".mission").css("border-bottom", "0");
    //
    $(".mission-statement").css("display", "none");
    $(".rp-container").css("display", "none");
    $(".niche-posts-section").fadeIn("fast");

})

$(".members").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139,77)";
    $(".discussions").css("border-bottom", "0");
    $(".mission").css("border-bottom", "0")
        //
    $(".mission-statement").css("display", "none");
    $(".niche-posts-section").css("display", "none");
    $(".rp-container").fadeIn("fast");

})