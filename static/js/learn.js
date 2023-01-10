/**
 *  code4export for learning board
 */
// more courses toggler
$(".section-intro1").click(function() {
    $(".courses").fadeToggle("slow");
});
// individual course control codes
let courseHeads = document.querySelectorAll(".course .head");
let courseFoots = document.querySelectorAll(".course .foot");
courseHeads.forEach(head => {
    head.state = 0;
    head.addEventListener("click", function() {

        if (head.state == 0) {
            head.parentNode.childNodes[3].style.display = "none";
            head.state = 1;
        } else {
            head.parentNode.childNodes[3].style.display = "block";
            head.state = 0;
        }
    });
});