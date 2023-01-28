// message box toggle
$(".msg-btn").click(function() {
    $(".msg-form").fadeToggle("slow");
});
// paths toggle code
$(".profile-paths .bio").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".profile-paths .network").style.borderBottom = "0";
    document.querySelector(".profile-paths .posts").style.borderBottom = "0";
    document.querySelector(".profile-paths .niches").style.borderBottom = "0";
    $(".bio-section").fadeIn("slow");
    $(".network-section").css("display", "none");
    $(".posts-section").css("display", "none");
    $(".niches-section").css("display", "none");

});
$(".profile-paths .network").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".profile-paths .bio").style.borderBottom = "0";
    document.querySelector(".profile-paths .posts").style.borderBottom = "0";
    document.querySelector(".profile-paths .niches").style.borderBottom = "0";
    $(".network-section").fadeIn("fast");
    $(".bio-section").css("display", "none");
    $(".posts-section").css("display", "none");
    $(".niches-section").css("display", "none");


});
$(".profile-paths .posts").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".profile-paths .network").style.borderBottom = "0";
    document.querySelector(".profile-paths .bio").style.borderBottom = "0";
    document.querySelector(".profile-paths .niches").style.borderBottom = "0";
    $(".posts-section").fadeIn("fast");
    $(".network-section").css("display", "none");
    $(".bio-section").css("display", "none");
    $(".niches-section").css("display", "none");

});
$(".profile-paths .niches").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".profile-paths .bio").style.borderBottom = "0";
    document.querySelector(".profile-paths .posts").style.borderBottom = "0";
    document.querySelector(".profile-paths .network").style.borderBottom = "0";
    $(".niches-section").fadeIn("fast");
    $(".network-section").css("display", "none");
    $(".posts-section").css("display", "none");
    $(".bio-section").css("display", "none");

});