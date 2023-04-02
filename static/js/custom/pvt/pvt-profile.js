$(".profile-path-btns .about").click(function() {
    $(".paths-con .about-path").fadeIn("fast");
    $(".paths-con .network-path").fadeOut("fast");
    $(".paths-con .posts-path").fadeOut("fast");
    $(".paths-con .communities-path").fadeOut("fast");
    //
    $(".profile-path-btns .network").css("border-bottom", "0");
    $(".profile-path-btns .about").css("border-bottom", "2px solid rgb(13, 139, 77)");
    $(".profile-path-btns .posts").css("border-bottom", "0");
    $(".profile-path-btns .communities").css("border-bottom", "0");
});
$(".profile-path-btns .network").click(function() {
    $(".paths-con .about-path").fadeOut("fast");
    $(".paths-con .network-path").fadeIn("fast");
    $(".paths-con .posts-path").fadeOut("fast");
    $(".paths-con .communities-path").fadeOut("fast");
    //
    $(".profile-path-btns .about").css("border-bottom", "0");
    $(".profile-path-btns .network").css("border-bottom", "2px solid rgb(13, 139, 77)");
    $(".profile-path-btns .posts").css("border-bottom", "0");
    $(".profile-path-btns .communities").css("border-bottom", "0");
});
$(".profile-path-btns .posts").click(function() {
    $(".paths-con .about-path").fadeOut("fast");
    $(".paths-con .network-path").fadeOut("fast");
    $(".paths-con .posts-path").fadeIn("fast");
    $(".paths-con .communities-path").fadeOut("fast");
    //
    $(".profile-path-btns .about").css("border-bottom", "0");
    $(".profile-path-btns .posts").css("border-bottom", "2px solid rgb(13, 139, 77)");
    $(".profile-path-btns .network").css("border-bottom", "0");
    $(".profile-path-btns .communities").css("border-bottom", "0");
});
$(".profile-path-btns .communities").click(function() {
    $(".paths-con .about-path").fadeOut("fast");
    $(".paths-con .network-path").fadeOut("fast");
    $(".paths-con .posts-path").fadeOut("fast");
    $(".paths-con .communities-path").fadeIn("fast");
    //
    $(".profile-path-btns .about").css("border-bottom", "0");
    $(".profile-path-btns .communities").css("border-bottom", "2px solid rgb(13, 139, 77)");
    $(".profile-path-btns .posts").css("border-bottom", "0");
    $(".profile-path-btns .network").css("border-bottom", "0");
});

function getDeviceWidth() {
    return window.innerWidth;
}
// toggle profile editing form
$(".profile-metadata-con .edit-btn").click(function() {
        // on mobile devices
        if (getDeviceWidth() < 992) {
            $(".all").fadeOut("slow");
        }
        $(".profile-edit-con .edit-form").fadeIn("slow");
    })
    // edit form cancel
$(".edit-form .edit-switch .edit-cancel").click(function() {
        $(".all").fadeIn("slow");
        $(".profile-edit-con .edit-form").fadeOut("slow");
    })
    /**
     *  let us get profile info
     */
$.post("/user/profile", {}, function(data, status) {
    //alert(data);
    let profileDetails = JSON.parse(data);
    document.querySelector(".profile-metadata-con .photo-con img").src = "/storage/profile/" + profileDetails.photo;
    document.querySelector(".profile-metadata-con .username").textContent = profileDetails.username;
    document.querySelector(".profile-metadata-con .full-name").textContent = profileDetails.first_name + " " + profileDetails.last_name;
    let fansCon = document.querySelector(".profile-metadata-con .stats .fans");
    fansCon.childNodes[0].textContent = profileDetails.fans;
    if (profileDetails.fans > 1) {
        fansCon.childNodes[1].textContent = " Fans";
    }
    document.querySelector(".profile-metadata-con .stats .liking b").textContent = profileDetails.liking;
    let likeBtn = document.querySelector(".profile-metadata-con .stats .like-btn");
    likeBtn.dataset.liked = "0";
    if (profileDetails.c_user_has_liked_acct == 1) {
        likeBtn.childNodes[1].textContent = "Liked";
        likeBtn.childNodes[1].style.color = "deeppink";
        likeBtn.childNodes[3].style.fill = "deeppink";
    } else {
        likeBtn.childNodes[1].textContent = "Like";
        likeBtn.childNodes[1].style.color = "grey";
        likeBtn.childNodes[3].style.fill = "grey";
    }
    /**
     *  let manage like or unlike functionality
     */
    likeBtn.addEventListener("click", function() {
        $.post("/user/likeness", { "liked": profileDetails.id }, function(data, status) {

            if (data == "created") {
                likeBtn.childNodes[1].textContent = "Liked";
                likeBtn.childNodes[1].style.color = "deeppink";
                likeBtn.childNodes[3].style.fill = "deeppink";
                //increase fans count by 1
                fansCon.childNodes[0].textContent = Number(fansCon.childNodes[0].textContent) + 1;
                if (Number(fansCon.childNodes[0].textContent) > 1) {
                    fansCon.childNodes[1].textContent = " Fans";
                } else {
                    fansCon.childNodes[1].textContent = " Fan";
                }
                //
            } else if (data == "deleted") {
                likeBtn.childNodes[1].textContent = "Like";
                likeBtn.childNodes[1].style.color = "grey";
                likeBtn.childNodes[3].style.fill = "grey";
                //decrease fans count by 1
                fansCon.childNodes[0].textContent = Number(fansCon.childNodes[0].textContent) - 1;
                if (Number(fansCon.childNodes[0].textContent) < 2) {
                    fansCon.childNodes[1].textContent = " Fan";
                } else {
                    fansCon.childNodes[1].textContent = " Fans";
                }

            } else {
                // do nothing...since this is an error signal
            }
        })
    });
    document.querySelector(".profile-metadata-con .intro").textContent = profileDetails.intro;
    if (profileDetails.friend_request_allowed == 1) {
        document.querySelector(".profile-metadata-con .send-friend-request").style.display = "inline";
    }

    /**
     *  direct messaging to profile account management code
     */
    let profileMsgForm = document.querySelector(".profile-msg-form");
    let pmfBody = document.querySelector(".profile-msg-form #profile-msg");
    let pmfBtn = document.querySelector(".profile-msg-form .sbt");
    pmfBody.onclick = function(eb) {
        eb.target.innerHTML = "";
    };
    profileMsgForm.addEventListener("submit", function(e) {
        e.preventDefault();
        let msgData = {
            "to": profileDetails.id,
            "body": pmfBody.value
        }
        $.post("/message/send", msgData, function(data, status) {
            //alert(data);
            if (data == 1) {
                pmfBtn.textContent = "Message Sent...";
                pmfBody.value = "";
                setTimeout(() => {
                    pmfBtn.textContent = "Send New Message";

                }, 1000);
            }
        });
    });


    // code to allow profile messaging form display or not
    if ((profileDetails.c_user_profile != 1) && (profileDetails.friend_request_allowed != 1)) {
        let msgSendController = document.querySelector(".profile-metadata-con .msg-send-controller");
        msgSendController.style.display = "inline";
        msgSendController.addEventListener("click", function() {
            $(".profile-msg-form").fadeToggle("slow");
        })
    }




    /**
     *  code to manage sending of friend request
     */
    let sendFrBtn = document.querySelector(".profile-metadata-con .send-friend-request");
    sendFrBtn.addEventListener("click", function() {
        $.post("/user/friend-request/send", {
            "person-id": profileDetails.id
        }, function(data, status) {
            //alert(data);
            if (data == 1) {
                sendFrBtn.style.display = "none";
            } else if (data == 0) {
                sendFrBtn.textContent = "Already sent...";
            } else {
                sendFrBtn.textContent = "Could Not Send Request...";
            }
        })
    })

    // it is the current user's profile. if that's the case, show the edit button and the form area
    if (profileDetails.c_user_profile == 1) {
        document.querySelector(".profile-metadata-con .edit-btn").style.display = "inline";
    }
    document.querySelector(".profile-metadata-con .date-registered").childNodes[1].textContent = profileDetails.date_registered;
    // about section
    document.querySelector(".about-path .dob").childNodes[1].textContent = profileDetails.dob;
    let gender = document.querySelector(".about-path .gender");
    if (profileDetails.gender == "m") {
        gender.childNodes[1].textContent = "Male";
    } else if (profileDetails.gender == "f") {
        gender.textContent = "Female";
    } else if (profileDetails.gender == "s") {
        gender.childNodes[1].textContent = "Special";
    } else {
        gender.childNodes[1].textContent = profileDetails.gender;
    }
    // career
    document.querySelector(".about-path .career-info").childNodes[1].textContent = profileDetails.school_info;
    document.querySelector(".about-path .work-info").childNodes[1].textContent = profileDetails.work_info;
    let marital_status = document.querySelector(".about-path .relationship-status");
    if (profileDetails.relationship == "s") {
        marital_status.childNodes[1].textContent = "Single";
    } else if (profileDetails.relationship == "m") {
        marital_status.childNodes[1].textContent = "Married";
    } else {
        marital_status.childNodes[1].textContent = "Not Specified Yet!";
    }
    // hobbies
    document.querySelector(".about-path .hobbies").childNodes[1].textContent = profileDetails.hobbies;
    document.querySelector(".about-path  .nationality").childNodes[1].textContent = profileDetails.nationality;

    // btn for querying next people position
    let nextPeoplePos = document.querySelector(".network-path .next-people");
    // container for persons
    let peopleCon = document.querySelector(".network-path .people");
    // let us fetch people connected to this profile
    $.post("/user/people-networked-to", {
        "acct-id": profileDetails.id,
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        let people = JSON.parse(data);
        if (people.length > 0) {

            people.forEach(person => {
                personMaker(person);
            });
            nextPeoplePos.dataset.nextPos = people.length;
        } else {
            // hide the next people btn & tell the user what's going on
            peopleCon.innerHTML = `<h6 class="p-5"> This Account Does Not Have Any Network Yet`;
            nextPeoplePos.style.visibility = "hidden";
        }

    });
    // next people group fetch
    nextPeoplePos.addEventListener("click", function() {
        $.post("/user/people-networked-to", {
            "acct-id": profileDetails.id,
            "starting": nextPeoplePos.dataset.nextPos,
            "amount": 5,
        }, function(data, status) {
            //alert(data);
            let nPeople = JSON.parse(data);
            if (nPeople.length > 0) {
                nPeople.forEach(nPerson => {
                    personMaker(nPerson);
                });
                nextPeoplePos.dataset.nextPos = (Number(nextPeoplePos.dataset.nextPos)) + nPeople.length;
            } else {
                nextPeoplePos.style.visibility = "hidden";
            }
        });
    })



    // helper function
    function personMaker(person) {
        // let's build fR cards
        let newFr = document.createElement("article");
        newFr.setAttribute("class", "person");
        // add friend request id to card
        newFr.dataset.personId = person.id;
        // sender photo
        let frImage = document.createElement("img");
        frImage.setAttribute("class", "image");
        frImage.src = "/storage/profile/" + person.photo;
        newFr.appendChild(frImage);
        // sender profile link
        let frSenderProfile = document.createElement("a");
        frSenderProfile.setAttribute("class", "name");
        frSenderProfile.href = "/user/" + person.username;
        frSenderProfile.textContent = person.username;
        newFr.appendChild(frSenderProfile);
        // now add to the requests container
        peopleCon.appendChild(newFr);
    }
    /**
     *  code to fetch posts created by this account
     * firstly, let's reference the next posts postion element
     *  and also container to store posts fetched...
     */


    //
    let postsCon = document.querySelector(".posts-path .userposts");
    let morePostsBtn = document.querySelector(".posts-path .more-profile-posts");
    $.post("/user/posts", {
        "profile_id": profileDetails.id,
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data)
        let posts = JSON.parse(data);
        if (posts.length > 0) {
            posts.forEach(post => {
                postCreator(post);
            });
            morePostsBtn.dataset.nextPos = Number(morePostsBtn.dataset.nextPos) + posts.length;
        } else {
            // show that no posts and hide the more posts button
            postsCon.innerHTML = `<h6 class="p-5"> No Posts Created By This Account Owner Yet...</h6>`;
            morePostsBtn.style.visibility = "hidden";
        }
    });
    // more posts button click code to fetch...of course...more posts made by the account
    morePostsBtn.addEventListener("click", function() {
        //alert(morePostsBtn.dataset.nextPos)
        $.post("/user/posts", {
            "profile_id": profileDetails.id,
            "starting": morePostsBtn.dataset.nextPos,
            "amount": 5
        }, function(data, status) {
            //alert(data);
            let morePosts = JSON.parse(data);
            if (morePosts.length > 0) {
                morePosts.forEach(mPost => {
                    postCreator(mPost);
                });
                // update next posts positioning
                morePostsBtn.dataset.nextPos = Number(morePostsBtn.dataset.nextPos) + morePosts.length;
            } else {
                //
                morePostsBtn.style.visibility = "hidden";
            }
        });
    });


    // helper function to create post cards
    function postCreator(post) {

        // create new post element
        let userpost = document.createElement("article");
        userpost.setAttribute("class", "userpost");
        // append into posts container
        postsCon.appendChild(userpost);
        //create post head
        let head = document.createElement("header");
        head.setAttribute("class", "head");
        userpost.appendChild(head);
        // create thumbnail if available
        if (post.pic != "") {
            let thumbnail = document.createElement("img");
            thumbnail.setAttribute("class", "post-thumbnail");
            thumbnail.src = `/storage/post/${post.pic}`;
            //alert(post.thumbnail);
            head.appendChild(thumbnail);
        }
        // post title
        let title = document.createElement("a");
        title.setAttribute("class", "title");
        title.href = `/post/${post.postid}/${post.slug}`;
        title.textContent = post.title;
        head.appendChild(title);
        // metadata container
        let metadata = document.createElement("footer");
        metadata.setAttribute("class", "metadata mb-1");
        userpost.appendChild(metadata);
        //user metadata con
        let userInfoCon = document.createElement("section");
        userInfoCon.setAttribute("class", "user-info");
        metadata.appendChild(userInfoCon);
        // poster photo
        let userPhoto = document.createElement("img");
        userPhoto.setAttribute("class", "photo");
        userPhoto.src = `/storage/profile/${post.user.photo}`;
        userInfoCon.appendChild(userPhoto);
        // misc user info
        let udCon = document.createElement("div");
        udCon.setAttribute("class", "ud");
        userInfoCon.appendChild(udCon);
        // username in udCon
        let uName = document.createElement("a");
        uName.setAttribute("class", "username");
        uName.href = `/user/${post.user.username}`;
        uName.textContent = post.user.username;
        udCon.appendChild(uName);
        // date in udCon
        let uDate = document.createElement("aside");
        uDate.setAttribute("class", "date");
        uDate.textContent = post.updated;
        udCon.appendChild(uDate);
        //stats con
        let statsCon = document.createElement("section");
        statsCon.setAttribute("class", "stats");
        metadata.appendChild(statsCon);
        // the state showing whether the current user has started following the post already
        let fState = "black";
        if (post.c_user_has_followed > 0) {
            fState = "deeppink";
        }
        // following con 
        let fCon = document.createElement("div");
        fCon.setAttribute("class", "following-con");
        fCon.dataset.postfollowed = post.postid;
        fCon.innerHTML = `
            <svg style="fill: ${fState};"  xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-heart follow-icon" viewBox="0 0 16 16">
            <path d="M9.828.722a.5.5 0 0 1 .354.146l4.95 4.95a.5.5 0 0 1 0 .707c-.48.48-1.072.588-1.503.588-.177 0-.335-.018-.46-.039l-3.134 3.134a5.927 5.927 0 0 1 .16 1.013c.046.702-.032 1.687-.72 2.375a.5.5 0 0 1-.707 0l-2.829-2.828-3.182 3.182c-.195.195-1.219.902-1.414.707-.195-.195.512-1.22.707-1.414l3.182-3.182-2.828-2.829a.5.5 0 0 1 0-.707c.688-.688 1.673-.767 2.375-.72a5.922 5.922 0 0 1 1.013.16l3.134-3.133a2.772 2.772 0 0 1-.04-.461c0-.43.108-1.022.589-1.503a.5.5 0 0 1 .353-.146zm.122 2.112v-.002.002zm0-.002v.002a.5.5 0 0 1-.122.51L6.293 6.878a.5.5 0 0 1-.511.12H5.78l-.014-.004a4.507 4.507 0 0 0-.288-.076 4.922 4.922 0 0 0-.765-.116c-.422-.028-.836.008-1.175.15l5.51 5.509c.141-.34.177-.753.149-1.175a4.924 4.924 0 0 0-.192-1.054l-.004-.013v-.001a.5.5 0 0 1 .12-.512l3.536-3.535a.5.5 0 0 1 .532-.115l.096.022c.087.017.208.034.344.034.114 0 .23-.011.343-.04L9.927 2.028c-.029.113-.04.23-.04.343a1.779 1.779 0 0 0 .062.46z"/>
            </svg>
            <aside class="count" >${post.following}</aside>
        `;
        statsCon.appendChild(fCon);
        // control post following
        fCon.addEventListener("click", function() {
            // check & update user for  post following state. it is a flipflop thing
            // follow unless the user is already following....then stop following.
            $.post("/post/following", {
                "post_id": fCon.dataset.postfollowed
            }, function(data, status) {
                //alert(data)
                if (data == "created") {
                    // change icon fill to reddish...

                    fCon.childNodes[1].style.fill = "deeppink";
                    fCon.childNodes[3].innerHTML = Number(fCon.childNodes[3].innerHTML) + 1;
                } else if (data == "deleted") {
                    // change to black
                    fCon.childNodes[1].style.fill = "black";
                    fCon.childNodes[3].innerHTML = Number(fCon.childNodes[3].innerHTML) - 1;
                } else {
                    // do nothing
                }
            });
        });
        // comments con
        let cCon = document.createElement("div");
        cCon.setAttribute("class", "comments-con");
        cCon.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat" viewBox="0 0 16 16">
            <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z"/>
            </svg>
            <aside class="count">${post.comments}</aside>
        `;
        statsCon.appendChild(cCon);
        //views-con
        let vCon = document.createElement("div");
        vCon.setAttribute("class", "views-con");
        vCon.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
            <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
            </svg>
            <aside class="count">${post.views}</aside>
        `;
        statsCon.appendChild(vCon);

        // post options menu
        let postMenu = document.createElement("div");
        postMenu.dataset.postid = post.postid;
        postMenu.dataset.postSlug = post.slug;
        postMenu.innerHTML = `
                <svg xmlns="http://www.w3.org/­2000/svg" data-bs-toggle="modal" data-bs-target="#postModal" width="20" height="20" fill="currentColor" class="bi bi-three-dots-vertic­al" viewBox="0 0 16 16"> <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/> </svg>       
            `;
        statsCon.appendChild(postMenu);
        postMenu.addEventListener("click", function() {
            //pass data
            let shareBtn = document.querySelector(".modal .share-btn");
            shareBtn.dataset.postId = postMenu.dataset.postid;
            shareBtn.dataset.postSlug = postMenu.dataset.postSlug;
            shareBtn.textContent = "Share Post...";
            shareBtn.addEventListener("click", shareMgr);

            function shareMgr(e) {
                navigator.share({
                    title: e.target.dataset.postSlug,
                    text: window.location.href,
                    ulr: `/post/${post.postid}/${post.slug}`
                }).then(
                    () => e.target.textContent = "Post Shared...",
                    (error) => e.target.textContent = "Post not shared"
                );
            }
        });


    }
    /**
     *  code to fetch niches that the account is a member
     */
    let nichesCon = document.querySelector(".communities-path .niches");
    let moreNichesBtn = document.querySelector(".communities-path .more-niches-btn");
    $.post("/user/niches", {
        "acct-id": profileDetails.id,
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        let niches = JSON.parse(data);
        if (niches.length > 0) {
            niches.forEach(niche => {
                nicheMaker(niche);

            });
            // update next niches position
            moreNichesBtn.dataset.nextPos = Number(moreNichesBtn.dataset.nextPos) + niches.length;
        } else {
            // show that there are no niches and hide next niches button
            nichesCon.innerHTML = `
                <h6 class="p-5"> No Niches Joined BY This Account Owner Yet...</h6>
            `;
            moreNichesBtn.style.visibility = "hidden";
        }
    });

    // more niches
    moreNichesBtn.addEventListener("click", function() {
        $.post("/user/niches", {
            "acct-id": profileDetails.id,
            "starting": moreNichesBtn.dataset.nextPos,
            "amount": 5
        }, function(data, status) {
            //alert(data);
            let niches2 = JSON.parse(data);
            if (niches2.length > 0) {
                niches2.forEach(niche2 => {
                    nicheMaker(niche2);

                });
                //update niche position
                moreNichesBtn.dataset.nextPos = Number(moreNichesBtn.dataset.nextPos) + niches2.length;
            } else {
                moreNichesBtn.style.visibility = "hidden";
            }

        });
    })


    function nicheMaker(niche) {
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

    /**
     *  code to manage joining & exiting niches 
     *  */
    // let memBtn = document.querySelector(".j_or_e");
    // memBtn.onclick = function(e) {
    //     $.post("/niche/join-or-leave", {
    //         "niche-id": memBtn.dataset.nicheId,
    //         "toggle": false
    //     }, function(data, status) {
    //         alert(data);
    //         if (data == 1) {
    //             memBtn.textContent = "Exit";
    //         } else if (data == 0) {
    //             memBtn.textContent = "Join";
    //         } else {
    //             memBtn.textContent = "Error Occurred...";
    //         }
    //     })
    // };


    /**
     *  code to manage user profile details changes
     *  firstly, let's populate the inputs with prefetched data
     */
    document.querySelector(".edit-form #email").value = profileDetails.email;
    document.querySelector(".edit-form #number").value = profileDetails.phone_number;
    document.querySelector(".edit-form #username").value = profileDetails.username;
    document.querySelector(".edit-form #fname").value = profileDetails.first_name;
    document.querySelector(".edit-form #lname").value = profileDetails.last_name;
    let imagePreview = document.querySelector(".edit-form .image-preview");
    imagePreview.src = "/storage/profile/" + profileDetails.photo;
    let newProfilePhotoInput = document.querySelector(".edit-form #profile-photo");
    // check for changes in input
    newProfilePhotoInput.addEventListener("change", function(e) {
        // preview image
        imagePreview.src = URL.createObjectURL(e.target.files[0]);

    });
    document.querySelector(".edit-form #dob").value = profileDetails.dob;
    document.querySelector(".edit-form #nationality").value = profileDetails.nationality;
    document.querySelector(".edit-form #intro").value = profileDetails.intro;
    document.querySelector(".edit-form #s-intro").value = profileDetails.school_info;
    document.querySelector(".edit-form #w-intro").value = profileDetails.work_info;
    document.querySelector(".edit-form #hobbies").value = profileDetails.hobbies;


    /**
     *  profile changes uploading mechanism
     */
    let profileForm = document.querySelector(".edit-form");
    profileForm.addEventListener("submit", function(e) {
        e.preventDefault();
        // uploading a photo is not mandatory
        if (newProfilePhotoInput.files.length > 0) {
            if (newProfilePhotoInput.files[0].size > 2000000) {
                // show state and don't send anything
                alert("file is to big...")
            } else {
                //send with photo
                let data = new FormData(profileForm);
                let xhttp = new XMLHttpRequest();
                xhttp.open("POST", "/user/profile/update");
                xhttp.onreadystatechange = function(e) {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        //alert(xhttp.response)
                        updateStateAction(xhttp.response);
                    }
                };
                xhttp.send(data);
            }


        } else {
            // send without photo
            let data = new FormData(profileForm);
            let xhttp = new XMLHttpRequest();
            xhttp.open("POST", "/user/profile/update");
            xhttp.onreadystatechange = function(e) {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    //alert(xhttp.response)
                    updateStateAction(xhttp.response);
                }
            };
            xhttp.send(data);

        }

    });

    function updateStateAction(stateObject) {
        let result = JSON.parse(stateObject);
        let changeState = document.querySelector(".edit-form .change-state");
        if (result.state == 1) {
            changeState.textContent = "Changes Saved...";
            setTimeout(() => {
                location.reload();
            }, 1000);
        } else if (result.state == 0) {
            changeState.textContent = "Could Not Be Saved...";
        } else {
            changeState.textContent = "Error Occurred...";
        }
    }

});