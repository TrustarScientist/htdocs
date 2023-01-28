$(".site-nav .head .bi-filter-left").click(function() {
    $(".site-nav .head .fancy-menu").fadeToggle("slow");
});
let navSearchBtnState = 0;
$(".site-nav .head .bi-search").click(function(e) {
    $(".site-nav .head .bi-search").html(
        `
        <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>`
    );
    if (navSearchBtnState == 0) {
        $(".site-nav .head .identity").fadeOut("slow").css("display", "none");
        $(".site-nav .head .bi-filter-left").fadeOut("slow").css("display", "none");
        $(".site-nav .head form").fadeIn("slow").css("display", "block").css("width", "85%");
        navSearchBtnState = 1;
    } else {
        $(".site-nav .head form").fadeOut("fast").css("display", "none").css("width", "0%");
        $(".site-nav .head .bi-filter-left").fadeIn("slow").css("display", "block");
        $(".site-nav .head .identity").fadeIn("slow").css("display", "flex");
        $(".site-nav .head .bi-search").html(
            `                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>`
        );

        navSearchBtnState = 0;
    }
});