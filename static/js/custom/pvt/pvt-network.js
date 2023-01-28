//code totoggle content  types
$(".s-people").click(function(e) {
    e.target.style.color = "rgb(13, 139, 77)";
    document.querySelector(".s-niches").style.color = "black";
    document.querySelector(".r-people").style.color = "black";
    document.querySelector(".r-niches").style.color = "black";
    // containers
    $(".people-display-con").fadeIn("fast");
    $(".niche-display-con").css("display", "none");
    $(".rpeople-display-con").css("display", "none");
    $(".rniche-display-con").css("display", "none");
});
$(".s-niches").click(function(e) {
    e.target.style.color = "rgb(13, 139, 77)";
    document.querySelector(".s-people").style.color = "black";
    document.querySelector(".r-people").style.color = "black";
    document.querySelector(".r-niches").style.color = "black";
    // containers
    $(".niche-display-con").fadeIn("fast");
    $(".people-display-con").css("display", "none");
    $(".rpeople-display-con").css("display", "none");
    $(".rniche-display-con").css("display", "none");
});
$(".r-people").click(function(e) {
    e.target.style.color = "rgb(13, 139, 77)";
    document.querySelector(".s-people").style.color = "black";
    document.querySelector(".s-niches").style.color = "black";
    document.querySelector(".r-niches").style.color = "black";
    // containers
    $(".rpeople-display-con").fadeIn("fast");
    $(".niche-display-con").css("display", "none");
    $(".people-display-con").css("display", "none");
    $(".rniche-display-con").css("display", "none");

});