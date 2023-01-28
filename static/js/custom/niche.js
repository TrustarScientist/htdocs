$(".about-con").click(function() {
    $(".about-details-con").fadeToggle("slow");
});

$(".paths .discussions").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".paths .members").style.borderBottom = "1px solid rgb(240, 240, 240)";
    $(".niche-posts-section").fadeIn("slow");
    $(".niche-members-section").css("display", "none");
});
$(".paths .members").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
    document.querySelector(".paths .discussions").style.borderBottom = "1px solid rgb(240, 240, 240)";
    $(".niche-posts-section").css("display", "none");
    $(".niche-members-section").fadeIn("slow");
});