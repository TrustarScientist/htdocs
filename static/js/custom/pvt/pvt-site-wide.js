let navStateVar = 0;
$(".pvt-nav .head .commons #search-icon").click(function() {
    if (navStateVar == 0) {
        $(".pvt-nav .head .commons #profile-icon").fadeOut("slow").css("display", "none");
        $(".pvt-nav .head .brand").fadeOut("slow").css("display", "none");
        $(".pvt-nav .head #form").fadeOut("slow").css("display", "block");
        $(".pvt-nav .head .commons #search-icon").html(
            `
        <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>`
        );
        navStateVar = 1;
    } else {
        $(".pvt-nav .head .commons #profile-icon").fadeIn("slow").css("display", "initial");
        $(".pvt-nav .head .brand").fadeIn("slow").css("display", "flex");
        $(".pvt-nav .head #form").fadeOut("slow").css("display", "none");
        $(".pvt-nav .head .commons #search-icon").html(
            `
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>`
        );
        navStateVar = 0;
    }
});
// events menu toggle code
$(".pvt-nav .head .bi-pen").click(function() {
    $(".events-menu").fadeToggle("fast");
});
/**
 *  code to fetch current user's info such as username, id, photo e.t.c
 */
$.post("/user/profile/self", {}, function(data, status) {
    let selfObject = JSON.parse(data);
    let cUserName = document.querySelector("#current-user");

    if (selfObject.username.length > 7) {
        cUserName.textContent = (selfObject.username.slice(0, 7) + "...");
    } else {
        cUserName.textContent = selfObject.username;
    }
    // current user profile link
    cUserName.parentNode.href = `/user/${selfObject.username}`

});
// events details toggle & fetching code
$(".events-menu .notifications").click(function() {
    $(".events-menu .n-d").slideToggle("slow");
})
$(".events-menu .messages").click(function() {
    $(".events-menu .m-d").slideToggle("slow");
})
$(".events-menu .frequests").click(function() {
        $(".events-menu .f-d").slideToggle("slow");
    })
    /**
     *  start other codes here...
     */

let siteHead = $(".pvt-nav .head");
let siteFoot = $(".pvt-nav .foot");

// scroll direction detector
let oldScrollY = window.screenY;
window.addEventListener("scroll", (e) => {
    if (getWidth() < 768) {
        let newScrollY = window.scrollY;
        if (newScrollY > oldScrollY) {
            // scroll up
            siteFoot.css("top", "0");
            siteHead.fadeOut("fast");
            $(".dcol:nth-child(2)").css("margin-top", "25px")

        } else {
            siteHead.fadeIn("fast", (e) => {
                siteFoot.css("top", "50px");
                $(".dcol:nth-child(2)").css("margin-top", "40px")
            });

        }
        oldScrollY = newScrollY;
    }
})

function getWidth() {
    return window.innerWidth;
}
// person creator
function personCreator(person, peopleCon = []) {

    let personObject = document.createElement("article");
    personObject.setAttribute("class", "person");
    personObject.innerHTML = `
    <img class="image" src="/storage/profile/${person.member[0].photo}" alt="person photo">
    <a href="/user/${person.member[0].username}" class="name">${person.member[0].username}</a>
    `;
    peopleCon.appendChild(personObject);
}

function postBuilder(post, userpostsCon = []) {
    //alert(post);
    let postCard = document.createElement("article");
    // if (!post.is_member) {
    //     postCard.setAttribute("style", "display:none");
    // } else {
    //     postCard.setAttribute("style", "display:block");
    // }
    postCard.setAttribute("class", "userpost");
    //
    let mainPImgShower = "none";

    if (post.pic != "") {
        mainPImgShower = "inline";
    }
    postCard.innerHTML = `
        <header class="head">
            <a href="/search?ct=${post.contenttype}" class="content-type">${post.contenttype}</a>
            <a href="/niche/${post.niche.alias}" class=" niche-name ">${post.niche.alias}</a>
        </header>
        <section class="middle ">
            <img src="/storage/post/${post.pic}" alt=" " class="post-thumbnail " style="display: ${mainPImgShower}">
            <a href="/post/${post.postid}/${post.slug}" class="title ">${post.title}</a>
        </section>
        <footer class="metadata mb-1 ">
            <section class="user-info ">
                <img src="/storage/profile/${post.user.photo}" alt=" " class="photo ">
                <div class="ud ">
                    <a href="/user/${post.user.username}" class="username ">${post.user.username}</a>
                    <aside class="date ">${post.updated}</aside>
                </div>
            </section>
            <section class="stats ">
                <div class="following-con ">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-heart" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                    </svg>
                    <aside class="count ">${post.following}</aside>
                </div>
                <div class="comments-con ">
                    <svg xmlns="http://www.w3.org/2000/svg " width="20 " height="20 " fill="currentColor " class="bi bi-chat " viewBox="0 0 16 16 ">
                            <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617
                                2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468
                                    1.105z "/>
                            </svg>
                    <aside class="count ">${post.comments}</aside>
                </div>
                <div class="views-con ">
                    <svg xmlns="http://www.w3.org/2000/svg " width="20 " height="20 " fill="currentColor " class="bi bi-eyeglasses " viewBox="0 0 16 16 ">
                            <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993
                            0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z "/>
                            </svg>
                    <aside class="count ">${post.views}</aside>
                </div>
                <div>
                    <svg xmlns="http://www.w3.org/­2000/svg " data-bs-toggle="modal" data-bs-target="#postModal" width="20 " height="20 " fill="currentColor " class="bi bi-three-dots-vertic­al " viewBox="0 0 16 16 "> <path d="M9.5
                        13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z "/> </svg>
                </div>
            </section>
        </footer>
    
    `
        //
    userpostsCon.appendChild(postCard);

    //followed or not
    if (post.c_user_has_followed == 1) {
        postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[1].innerHTML = `<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>`;
        postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[1].style.fill = "deeppink";
    } else {
        postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[1].innerHTML = `<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>`;
        postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[1].style.fill = "grey";
    }
    // followership event handling
    postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[1].addEventListener("click", (fE) => {
        // check & update user for  post following state. it is a flipflop thing
        // follow unless the user is already following....then stop following.
        $.post("/post/following", {
            "post_id": post.postid
        }, function(data, status) {
            //alert(data)
            if (data == "created") {
                // change icon fill to reddish...

                fE.target.style.fill = "deeppink";
                fE.target.innerHTML = `<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>`;
                postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[3].innerHTML = Number(postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[3].innerHTML) + 1;
            } else if (data == "deleted") {
                // change to black
                fE.target.style.fill = "grey";
                fE.target.innerHTML = `<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>`;
                postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[3].innerHTML = Number(postCard.childNodes[5].childNodes[3].childNodes[1].childNodes[3].innerHTML) - 1;
            } else {
                // do nothing
            }
        });
    });




    // edit button if it current user's post 
    // and blocking of posters
    postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.pid = post.postid;
    postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.poster = post.user.id;
    postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.postername = post.user.username;
    postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.ownership = post.own;
    postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].addEventListener("click", (menuE) => {

        let editFYours = document.querySelector(".edit-if-its-yours");
        if (editFYours != null) {
            if (editFYours.dataset.cuser == post.user.id) {
                editFYours.textContent = "Edit this your post...";
                editFYours.href = `/post/edit?action=update&postid=${post.postid}`;
                editFYours.style.display = "inline";
            }
        }

        /**
         *  Blocking of post creators
         *  first, we need to check the blockage state
         */
        let userBlockingBtn = document.querySelector(".block-user");
        userBlockingBtn.dataset.u2b = postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.poster;
        let posterId = postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.poster;
        let postername = postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.postername;
        //alert(posterId)
        $.post("/user/blacklist", {
            "user_to_block": post.user.id
        }, (data, status) => {
            if (data == "np") {
                // u cant block yourself
                userBlockingBtn.style.display = "none";
            } else if (data == "nb") {
                userBlockingBtn.style.display = "block";
                userBlockingBtn.innerHTML = `Block Posts from <b>${postername}<b>`;
            } else if (data = "b") {
                userBlockingBtn.style.display = "block";
                userBlockingBtn.innerHTML = `Unblock Posts from <b>${postername}<b>`;
            }
        });


        let editBtn = document.querySelector(".edit-post");

        if (postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.ownership == 1) {
            editBtn.style.display = "block";
            editBtn.textContent = "Edit This Post...";
            editBtn.href = `/post/edit?action=update&postid=${postCard.childNodes[5].childNodes[3].childNodes[7].childNodes[1].dataset.pid}`;
        } else {
            editBtn.style.display = "none";
            editBtn.textContent = "You can't Edit This Post...";
            editBtn.href = `/post/edit`;
        }
    })

}

// niche creator
function nicheMaker2(niche, nichesCon = '') {
    // create niche card
    let newNiche = document.createElement("article");
    newNiche.setAttribute("class", "niche");
    newNiche.innerHTML = `
        <a href="/niche/${niche.alias}" class="name ">${niche.name}</a>
        <span class="alias btn text-success">${niche.alias}</span>
    `;
    let nFoot = document.createElement("footer");
    nFoot.setAttribute("class", "foot");
    //manage memebrship & posts count
    let mems = (niche.members > 1) ? "Members" : "Member";
    let posts = (niche.posts > 1) ? "Posts" : "Post";

    //
    nFoot.innerHTML = `
        <div class="info">
        <img class="banner" src="${niche.banner}" alt="">
        <header class="mem"><b class="mem-count">${niche.members}</b> <span>${mems}</span></header>
        <header class="post"><b class="mem-count">${niche.posts}</b> <span>${posts}</span></header>
        </div>
    `;
    // menu button for niche options
    let menuBtnCon = document.createElement("aside");
    menuBtnCon.dataset.nicheId = niche.id;
    if (niche.c_user_is_member == 1) {
        menuBtnCon.dataset.state = "Exit";
    } else {
        menuBtnCon.dataset.state = "Join";
    }
    menuBtnCon.innerHTML = `<svg xmlns="http://www.w3.org/­2000/svg" data-bs-toggle="modal" data-bs-target="#nicheModal" width="20" height="20" fill="currentColor" class="bi bi-three-dots-vertic­al" viewBox="0 0 16 16"> <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/> </svg>`;
    nFoot.appendChild(menuBtnCon);
    // add data attributes 4 later use on clicking the menuBtnCon to necessary buttons
    menuBtnCon.addEventListener("click", function(e) {
        // dynamically check whether the current user is a member or not
        let membershipBtn = document.querySelector(".j_or_e");
        membershipBtn.dataset.nicheId = menuBtnCon.dataset.nicheId;
        // check membership status
        $.post("/niche/join-or-leave", {
            "niche-id": membershipBtn.dataset.nicheId,
            "toggle": 0
        }, function(data, status) {
            if (data == "nam") {
                membershipBtn.textContent = "Join niche...";
            } else if (data == "am") {
                membershipBtn.textContent = "Leave niche...";
            }

        });
        // let's current be able to join or exit the niche of a post
        membershipBtn.addEventListener("click", joinOrLeave);

        function joinOrLeave(e) {
            $.post("/niche/join-or-leave", {
                "niche-id": membershipBtn.dataset.nicheId,

            }, function(data, status) {
                //alert(data);
                if (data == 1) {
                    e.target.textContent = "You have joined the niche...";
                } else if (data == 0) {
                    e.target.textContent = "You have left the niche...";

                } else {
                    e.target.textContent = "Something went wrong";
                }

                e.target.removeEventListener("click", joinOrLeave);

            });
        }


    });


    //
    newNiche.appendChild(nFoot);
    nichesCon.appendChild(newNiche);

}