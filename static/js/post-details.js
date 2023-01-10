$(".details .choices .comment").click(function() {
    $(".details .comment-form").fadeToggle("slow");
});
//reply box control code
let replyBoxControllers = document.querySelectorAll(".comment-box .cstats .reply-count");
replyBoxControllers.forEach(rBc => {
    rBc.addEventListener("click", function() {

        if (rBc.dataset.state == "0") {
            rBc.parentNode.parentNode.childNodes[7].style.display = "block";
            rBc.dataset.state = "1";
        } else {
            rBc.parentNode.parentNode.childNodes[7].style.display = "none";
            rBc.dataset.state = "0";
        }
    });
});