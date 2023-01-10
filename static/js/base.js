// requesting for list of courses
$.post("/learn/courses", {
    "limit": 3
}, function(data, status) {
    let coursesCon = document.querySelector(".courses");
    let course = document.querySelector(".courses .course");
    // convert json to js obj
    //alert(data)
    let jsDataSet = JSON.parse(data);
    if (jsDataSet != {}) {
        jsDataSet.forEach(jsData => {
            // create new element for each  node
            let newElem = document.createElement("a");
            newElem.setAttribute("class", "course btn btn-outline-primary");
            newElem.dataset.id = jsData.id;
            newElem.href = `/learn/course/${jsData.slug}`;
            coursesCon.appendChild(newElem);
            // h1
            let hOne = document.createElement("h1");
            hOne.setAttribute("class", "head");
            newElem.appendChild(hOne);
            //img
            let img = document.createElement("img");
            img.setAttribute("class", "banner");
            img.src = jsData.banner;
            hOne.appendChild(img);
            //h6
            let hSix = document.createElement("h6");
            hSix.setAttribute("class", "title");
            hSix.textContent = jsData.title;
            hOne.appendChild(hSix);
        });

    } else {
        coursesCon.innerHTML = "<h1> We could not fetch the available courses...try again later";
    }
})