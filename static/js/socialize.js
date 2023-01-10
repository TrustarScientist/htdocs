$(".post-add-btn").click(function() {
    $(".editor-container").fadeIn("slow");
});
$(".editor-container .direction #cancel").click(function() {
    $(".editor-container").fadeOut("slow");
});
// pre description for post textarea
let postTextArea = document.querySelector(".editor-container .editor #content");
postTextArea.textContent = "Description of post";
postTextArea.onclick = function() {
    postTextArea.textContent = "";
}