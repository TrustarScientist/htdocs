var a = 1
var before;
$(document).click(function(e) {
    if (e.target !== before) {
        alert('ok')
        a = 1
    }
    if (e.target.parentNode.nextElementSibling.className == "cs-mat-and-test-con" && e.target.className == "cs-title") {
        alert(123)

        let targe = e.target.parentNode.nextElementSibling.style
        if (a == 1) {
            targe.opacity = 0
            targe.height = "0px"
            a = 0
        } else if (a == 0) {
            targe.opacity = 1
            targe.height = "200px"
            a = 1
        } else {
            alert(a)
        }
    }
    before = e.target
})