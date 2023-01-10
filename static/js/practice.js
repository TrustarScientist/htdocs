let vlabs = document.querySelectorAll(".vlab");
let labFrame = document.querySelector(".lab-active-container .frame");
vlabs.forEach(lab => {
    lab.addEventListener("click", function() {
        if (lab.dataset.active == "0") {
            $(".lab-active-container").fadeIn("slow").css("display", "block");
            lab.dataset.active == "1";
        } else {
            labFrame.src = lab.dataset.url;
            $(".lab-active-container").fadeIn("slow").css("display", "block");
            lab.dataset.active == "0"
        }
    });
});