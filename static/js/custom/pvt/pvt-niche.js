$(".mission").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139,77)";
    $(".discussions").css("border-bottom", "0");
    $(".members").css("border-bottom", "0");
    //
    $(".niche-posts-section").css("display", "none");
    $(".rp-container").css("display", "none");
    $(".mission-statement").fadeIn("fast");

})

$(".discussions").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139,77)";
    $(".members").css("border-bottom", "0");
    $(".mission").css("border-bottom", "0");
    //
    $(".mission-statement").css("display", "none");
    $(".rp-container").css("display", "none");
    $(".niche-posts-section").fadeIn("fast");

})

$(".members").click(function(e) {
    e.target.style.borderBottom = "2px solid rgb(13, 139,77)";
    $(".discussions").css("border-bottom", "0");
    $(".mission").css("border-bottom", "0")
        //
    $(".mission-statement").css("display", "none");
    $(".niche-posts-section").css("display", "none");
    $(".rp-container").fadeIn("fast");

})

setTimeout(() => {
    $(".dcol:nth-child(2)").fadeIn("slow");
    document.querySelector(".sitewide-loader").style.display = "none";
    /**
     *  let's get  niche alias from URL
     */
    let nicheAlias = /[\/\w:\d\.]+\/niche\/(@\w+)/.exec(window.location.href);
    let nicheId = 0;
    // get niche info
    $.post(`/niche/details`, {
        "niche-alias": nicheAlias[1]
    }, function(data, status) {
        //alert(data);
        try {
            let nicheData = JSON.parse(data);
            if (nicheData != []) {
                nicheId = nicheData.id;
                document.querySelector(".niche-name").textContent = nicheData.name;
                let membershipBtn = document.querySelector(".niche-membership");
                membershipBtn.dataset.nid = nicheData.id;
                if (nicheData.cuser_is_member) {
                    membershipBtn.textContent = "Leave";
                } else {
                    membershipBtn.textContent = "Join";
                }
                document.querySelector(".niche-banner").src = nicheData.banner;
                document.querySelector(".mission-statement .body").textContent = nicheData.description;
                // related niches
                let relatedNichesCon = document.querySelector(".related-niches-container");
                if (nicheData.related_niches.length > 0) {
                    nicheData.related_niches.forEach(relatedNiche => {
                        let rnLink = document.createElement("a");
                        rnLink.textContent = relatedNiche;
                        rnLink.href = `/niche/${relatedNiche}`;
                        relatedNichesCon.appendChild(rnLink);
                    });
                } else {
                    document.querySelector(".rns-heading").style.display = "none";
                }
                // code to fetch niche posts
                let moreNichePostsBtn = document.querySelector(".more-niche-posts");

                let userpostsParent = document.querySelector(".userposts");
                $.post("/niche/pvt/posts", {
                    "niche-id": nicheData.id,
                    "starting": 0,
                    "amount": 7
                }, (data, status) => {
                    //alert(data);
                    let nPosts = JSON.parse(data);
                    if (nPosts.length > 0) {
                        moreNichePostsBtn.style.display = "inline";
                        nPosts.forEach(np => {
                            if (!np.poster_blocked) {
                                postBuilder(np, userpostsParent);
                            }

                        });
                        moreNichePostsBtn.dataset.nextPos = Number(moreNichePostsBtn.dataset.nextPos) + nPosts.length;
                    } else {
                        userpostsParent.innerHTML = `<h4 class="p-5"> No Posts in this Niche...Yet </h4>`;
                    }
                });

                //more niche posts
                moreNichePostsBtn.addEventListener("click", (mnpEvent) => {
                        //
                        //alert(moreNichePostsBtn.dataset.nextPos)
                        $.post("/niche/pvt/posts", {
                            "niche-id": nicheData.id,
                            "starting": moreNichePostsBtn.dataset.nextPos,
                            "amount": 7
                        }, (data, status) => {
                            //alert(data);
                            let nPosts2 = JSON.parse(data);
                            if (nPosts2.length > 0) {

                                nPosts2.forEach(np2 => {
                                    if (!np2.poster_blocked) {
                                        postBuilder(np2, userpostsParent);
                                    }

                                });
                                moreNichePostsBtn.dataset.nextPos = Number(moreNichePostsBtn.dataset.nextPos) + nPosts2.length;
                            } else {
                                moreNichePostsBtn.style.display = "none";
                            }
                        })
                    })
                    // code to block or unblock pot creators by the current user
                let blockingBtn = document.querySelector(".block-user");
                blockingBtn.addEventListener("click", (e) => {
                    $.post("/user/blacklist", {
                        "user_to_block": blockingBtn.dataset.u2b,
                        "toggle": "yes"
                    }, (data, status) => {
                        //alert(data);
                        if (data == "blocked") {
                            blockingBtn.textContent = "User Blocked...";
                        } else if (data == "unblocked") {
                            blockingBtn.textContent = "User Unblocked";
                        }
                    });
                });
            }
        } catch (error) {
            alert(error)
        }
    });
    // leaving or joining niches functionality
    let nicheJorL = document.querySelector(".niche-membership");
    nicheJorL.addEventListener("click", (njlEvent) => {
        $.post("/niche/join-or-leave", {
            "niche-id": nicheJorL.dataset.nid,
            "toggle": 1
        }, (data, status) => {
            //alert(data);
            if (data == "0") {
                nicheJorL.textContent = "You have left the niche...";
            } else {
                nicheJorL.textContent = "You have entered the niche...";
            }
        });
    });




    // get niche members
    let morePeopleBtn = document.querySelector(".next-people");
    let peopleContainer = document.querySelector(".people");
    $.post("/niche/members", {
        "niche-alias": nicheAlias[1]
    }, (data, status) => {
        //alert(data);
        let pData = JSON.parse(data);
        if (pData.length > 0) {
            pData.forEach(person => {
                personCreator(person, peopleContainer);
            });
            morePeopleBtn.dataset.pos = Number(morePeopleBtn.dataset.pos) + pData.length;

        } else {
            peopleContainer.innerHTML = `<h4 class="p-5"> No Members...Yet`;

        }
    });

    // more members
    morePeopleBtn.addEventListener("click", (data, status) => {
        $.post("/niche/members", {
            "niche-alias": nicheAlias[1]
        }, (data, status) => {
            let pData2 = JSON.parse(data);
            if (pData2.length > 0) {
                pData2.forEach(pd2 => {
                    personCreator(pd2, peopleContainer);
                });
                morePeopleBtn.dataset.pos = Number(morePeopleBtn.dataset.pos) + pData2.length;

            } else {
                morePeopleBtn.style.display = "none";
            }
        })
    })

}, 500);