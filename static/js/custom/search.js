$(document).ready(function() {
    // next btn
    let nextResultBtn = document.querySelector(".more-results-btn");


    let dataset = {
        "starting": 0,
        "amount": 7
    };
    postAggregator("/search", dataset, nextResultBtn);
    /**
     *  code to fetch more posts when the next button is clicked
     */
    $(".more-results-btn").click(function(e) {
        let startingPoint = (e.target.dataset.next);
        postAggregator("/search", {
            "starting": startingPoint,
            "amount": 7
        }, nextResultBtn);
    });


});

function postAggregator(url, dataset = "", nextResultBtn = "") {
    $.post(
        url,
        dataset,
        function(data, status) {
            //alert(data)
            // check for empty response data
            if (data != "[]") {
                // convert data to Js object
                let responseData = JSON.parse(data);
                // show query in search box
                let mainSearchBox = document.querySelector("#q");
                mainSearchBox.value = responseData[0].query;
                let altSearchBox = document.querySelector("#alt-search-box");
                altSearchBox.value = responseData[0].query;
                responseData.forEach(postObject => {
                    // get data starting position of 0
                    let postsContainer = document.querySelector(".userposts");
                    let userpost = document.createElement("div");
                    userpost.setAttribute("class", "userpost bg-light");
                    postsContainer.appendChild(userpost);
                    //post head
                    let head = document.createElement("header");
                    head.setAttribute("class", "head mb-1");
                    userpost.appendChild(head);
                    // username in head
                    let hAnchor = document.createElement("a");
                    hAnchor.href = `/user/${postObject.user.username}`;
                    hAnchor.textContent = postObject.user.username;
                    head.appendChild(hAnchor);
                    //dot in  head
                    let hDot = document.createElement("span");
                    hDot.setAttribute("class", "dot");
                    head.appendChild(hDot);
                    //date in head
                    let hDate = document.createElement("span");
                    hDate.setAttribute("class", "date");
                    hDate.textContent = postObject.updated;
                    head.appendChild(hDate);
                    // content container
                    let contentContainer = document.createElement("article");
                    contentContainer.setAttribute("class", "content-con");
                    userpost.appendChild(contentContainer);
                    // optional image in content
                    if (postObject.pic != "") {
                        let cImage = document.createElement("img");
                        cImage.src = `/storage/post/${postObject.pic}`;
                        cImage.alt = "post image";
                        contentContainer.appendChild(cImage);
                    }
                    // post title in content
                    let cTitle = document.createElement("a");
                    cTitle.setAttribute("class", "title");
                    cTitle.href = `/post/${postObject.postid}/${postObject.slug}`;
                    cTitle.textContent = postObject.title;
                    contentContainer.appendChild(cTitle);
                    // foot
                    let foot = document.createElement("foot");
                    foot.setAttribute("class", "metadata mt-1 pt-1");
                    userpost.appendChild(foot);
                    // niche info in foot
                    let fNicheCon = document.createElement("section");
                    fNicheCon.setAttribute("class", "niche-info");
                    foot.appendChild(fNicheCon);
                    // anchor in niche info in foot
                    let fAnchor = document.createElement("a");
                    fAnchor.setAttribute("class", "btn btn-success");
                    fAnchor.href = `/niche/${postObject.niche.alias}`;
                    fAnchor.textContent = postObject.niche.alias;
                    fNicheCon.appendChild(fAnchor);
                    // stats con in foot
                    let statsCon = document.createElement("section");
                    statsCon.setAttribute("class", "stats");
                    foot.appendChild(statsCon);
                    // following con in stats
                    let sFollowingCon = document.createElement("div");
                    sFollowingCon.innerHTML = `
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-heart" viewBox="0 0 16 16">
                        <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                        </svg>
                        <aside class="count">${postObject.following}</aside>
                    `;
                    statsCon.appendChild(sFollowingCon);
                    // comments con in stats
                    let commentsCon = document.createElement("div");
                    commentsCon.innerHTML = `
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-chat" viewBox="0 0 16 16">
                        <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z"/>
                        </svg>
                        <aside class="count">${postObject.comments}</aside>
                    `;
                    statsCon.appendChild(commentsCon);
                    // views con in stats
                    let viewsCon = document.createElement("div");
                    viewsCon.innerHTML = `
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                        <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                        </svg>
                        <aside class="count">${postObject.views}</aside>
                    `;
                    statsCon.appendChild(viewsCon);
                    //update prev and next buttons
                    nextResultBtn.dataset.next = (Number(nextResultBtn.dataset.next) + 1);

                });
            } else {
                let userpostsContainer = document.querySelector(".userposts");
                let searchState = document.createElement("h2");
                searchState.textContent = "We Can't Find Anything...";
                userpostsContainer.appendChild(searchState);
                document.querySelector(".more-results-btn").style.visibility = "hidden";
            }
        }
    );

}