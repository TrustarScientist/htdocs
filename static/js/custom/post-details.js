$(".related-posts-con .post-chain-btn").click(function() {
    $(".related-posts-con .post-chain-posts").fadeToggle("slow").css("display", "flex");
});
// comment section vs relted posts section control code
$(".details-paths .comments").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".details-paths .related-posts").style.borderBottom = "0";
    $(".comment-section").fadeIn("fast")
    $(".related-posts-section").fadeOut("fast")
});
$(".details-paths .related-posts").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".details-paths .comments").style.borderBottom = "0";
    $(".comment-section").fadeOut("fast")
    $(".related-posts-section").fadeIn("fast")
});
// comment add toggle
$(".comment-add-btn").click(function() {
    $(".comment-form").fadeToggle("slow")
});