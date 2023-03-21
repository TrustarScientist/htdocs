$(document).ready(function() {
    /**
     *  code to manage friend requests
     */

    let friendRequestsContainer = document.querySelector(".friend-requests");
    let moreFrPositonBtn = document.querySelector(".more-fr");

    $.post("/user/friend-requests", {
        "starting": 0,
        "amount": 1
    }, function(data, status) {
        //alert(data)
        // convert to Js Object
        let friendRequests = JSON.parse(data);
        if (friendRequests.length > 0) {
            // hide default text
            friendRequests.forEach(fR => {

                frCardMaker(fR);
                // update next fr fetch position
                moreFrPositonBtn.dataset.frPos = Number(moreFrPositonBtn.dataset.frPos) + 1;
            });
        } else {
            // no friend requests
            friendRequestsContainer.innerHTML = `<h6 class="p-3 ps-3"> No Friend Requests...Yet</h1>`;
            moreFrPositonBtn.style.display = "none";
        }
    });
    // more friend requests on click
    moreFrPositonBtn.addEventListener("click", function(e) {

        $.post("/user/friend-requests", {
            "starting": this.dataset.frPos,
            "amount": 1
        }, function(data2, status) {
            //alert(data2);
            // convert
            let nextFrs = JSON.parse(data2);
            if (nextFrs.length > 0) {

                nextFrs.forEach(nFr => {
                    frCardMaker(nFr);
                    moreFrPositonBtn.dataset.frPos = Number(moreFrPositonBtn.dataset.frPos) + 1;
                });
            } else {
                // no more friend requests
                moreFrPositonBtn.style.display = "none";
            }
        });
    });

    function frCardMaker(fR) {
        // let's build fR cards
        let newFr = document.createElement("article");
        newFr.setAttribute("class", "person");
        // add friend request id to card
        newFr.dataset.frId = fR.id;
        // like icon container
        let likeIcon = document.createElement("header");
        likeIcon.setAttribute("class", "like-icon");
        likeIcon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" data-bs-toggle="modal" data-bs-target="#request-options" width="20" height="20" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
        </svg>`;
        /**
         *  add listener to trigger request options in modal
         */
        likeIcon.addEventListener("click", function(e) {
                // request acceptance code
                let acceptBtn = document.querySelector("#request-options .accept");
                acceptBtn.textContent = "Accept";
                acceptBtn.dataset.frId = fR.id;
                acceptBtn.dataset.senderId = fR.sender.id;
                acceptBtn.onclick = function(e) {
                        $.post("/user/connection/accept", {
                            "fr-id": this.dataset.frId,
                            "sender-id": this.dataset.senderId
                        }, function(data, status) {
                            // alert(data)
                            /**
                             *  if the acceptance is a success, we need to display:none that appropriate friend request card
                             *  
                             */
                            if (data == 1) {
                                //alert("wanna dn it");
                                let allFrCards = document.querySelectorAll(".friend-requests .person");
                                if (allFrCards.length > 0) {
                                    allFrCards.forEach(frCard => {
                                        if (frCard.dataset.frId == acceptBtn.dataset.frId) {
                                            frCard.style.display = "none";
                                        }
                                    });
                                }
                                acceptBtn.textContent = "Friend Request Accepted";
                            }
                        });
                    }
                    // request rejection code
                let rejectBtn = document.querySelector("#request-options .reject");
                rejectBtn.textContent = "Reject";
                rejectBtn.dataset.frId = fR.id;
                rejectBtn.dataset.senderId = fR.sender.id;
                rejectBtn.onclick = function() {
                    $.post("/user/connection/rejection", {
                        "fr-id": rejectBtn.dataset.frId,
                        "sender-id": rejectBtn.dataset.senderId
                    }, function(data, status) {
                        //alert(data);
                        if (data == 1) {

                            let allFrCards = document.querySelectorAll(".friend-requests .person");
                            if (allFrCards.length > 0) {
                                allFrCards.forEach(frCard => {
                                    if (frCard.dataset.frId == rejectBtn.dataset.frId) {
                                        frCard.style.display = "none";
                                    }
                                });
                            }
                            rejectBtn.textContent = "Friend Request Rejected";
                        }
                    });
                };

            })
            // append to list
        newFr.appendChild(likeIcon);
        // sender photo
        let frImage = document.createElement("img");
        frImage.setAttribute("class", "image");
        frImage.src = "/storage/profile/" + fR.sender.photo;
        newFr.appendChild(frImage);
        // sender profile link
        let frSenderProfile = document.createElement("a");
        frSenderProfile.setAttribute("class", "name");
        frSenderProfile.href = "/user/" + fR.sender.username;
        frSenderProfile.textContent = fR.sender.username;
        newFr.appendChild(frSenderProfile);
        // now add to the requests container
        friendRequestsContainer.appendChild(newFr);
    }

    /**
     *  code for fetching recommended people
     */
    let recommendedPeopleContainer = document.querySelector(".recommended-people");
    $.post("/user/recommended-people", {}, function(data, status) {
        //alert(data);
        let recPeople = JSON.parse(data);
        if (recPeople.length > 0) {
            recPeople.forEach(rPerson => {
                recPersonMaker(rPerson);
            });
        }
    })




    // helper function
    function recPersonMaker(person) {
        // let's build fR cards
        let newFr = document.createElement("article");
        newFr.setAttribute("class", "person");
        // add friend request id to card
        newFr.dataset.personId = person.id;
        // like icon container
        let sendFrIcon = document.createElement("header");
        sendFrIcon.setAttribute("class", "like-icon");
        sendFrIcon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" data-bs-toggle="modal" data-bs-target="#connection-options" width="20" height="20" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
        </svg>`;
        /**
         *  add listener to trigger request options in modal
         */
        sendFrIcon.addEventListener("click", function(e) {
                /**
                 *  let's manage the friend request thing Niga!!!
                 */
                let frBtn = document.querySelector("#connection-options .send-fr");
                frBtn.dataset.personId = person.id;
                frBtn.onclick = function(e) {
                    $.post("/user/friend-request/send", {
                        "person-id": frBtn.dataset.personId
                    }, function(data, status) {
                        //alert(data);
                        if (data == 1) {
                            newFr.style.display = "none";
                        }

                    });
                };

            })
            // append to list
        newFr.appendChild(sendFrIcon);
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
        recommendedPeopleContainer.appendChild(newFr);
    }
    /**
     *  display known people...in series
     */
    let yourPeopleCon = document.querySelector(".your-people");
    let moreOfYourPeople = document.querySelector(".your-people-more");
    moreOfYourPeople.dataset.ypMore = "0";

    $.post("/user/people-networked-to", {
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        let yourPeople = JSON.parse(data);

        if (yourPeople.length > 0) {
            yourPeople.forEach(yourPerson => {
                yourPersonMaker(yourPerson);
            });
            //update moreYourPeople
            moreOfYourPeople.dataset.ypMore = Number(moreOfYourPeople.dataset.ypMore) + yourPeople.length;
        } else {
            // hidden next Your People BTN
            yourPeopleCon.innerHTML = `<h6 class="p-3"> You Do NoT Have Any Network...Yet </h>`;
            moreOfYourPeople.style.display = "none";
        }




    });
    // more of your people button in action
    moreOfYourPeople.addEventListener("click", function(e) {
        $.post("/user/people-networked-to", {
            "starting": this.dataset.ypMore,
            "amount": 5
        }, function(data, status) {
            //alert(data);
            let yourPeople2 = JSON.parse(data);

            if (yourPeople2.length > 0) {
                yourPeople2.forEach(yourPerson2 => {
                    yourPersonMaker(yourPerson2);
                });
                //update moreYourPeople
                moreOfYourPeople.dataset.ypMore = Number(moreOfYourPeople.dataset.ypMore) + yourPeople2.length;
            } else {
                // hidden next Your People BTN
                moreOfYourPeople.style.display = "none";
            }




        });
    })


    // helper function
    function yourPersonMaker(person) {

        // let's build fR cards
        let newP = document.createElement("article");
        newP.setAttribute("class", "person");
        // add friend request id to card
        newP.dataset.personId = person.id;
        // your person option
        let option = document.createElement("header");
        option.dataset.personStopped = person.id;
        option.setAttribute("class", "like-icon");
        option.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" data-bs-toggle="modal" data-bs-target="#network-options" width="20" height="20" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
            </svg>`;
        /**
         *  add listener to trigger request options in modal
         */
        option.addEventListener("click", function(e) {
                /**
                 *  code for options such as stopping relationship
                 * 
                 */
                let stopConnectionBtn = document.querySelector(".stop-connection");
                stopConnectionBtn.addEventListener("click", function(e) {
                    stopConnectionBtn.textContent = "Stop Friendship";
                    $.post("/user/friendship/stop", {
                        "person-2-stop-id": option.dataset.personStopped
                    }, function(data, status) {
                        //alert(data);
                        if (data == 1) {
                            stopConnectionBtn.textContent = "Friendship Stopped...";
                            newP.style.display = "none";
                        } else {
                            stopConnectionBtn.textContent = "Something Went Wrong...";
                        }
                    })
                });
            })
            // append to list
        newP.appendChild(option);
        // person's photo
        let frImage = document.createElement("img");
        frImage.setAttribute("class", "image");
        frImage.src = "/storage/profile/" + person.photo;
        newP.appendChild(frImage);
        // sender profile link
        let frSenderProfile = document.createElement("a");
        frSenderProfile.setAttribute("class", "name");
        frSenderProfile.href = "/user/" + person.username;
        frSenderProfile.textContent = person.username;
        newP.appendChild(frSenderProfile);
        // now add to the requests container
        yourPeopleCon.appendChild(newP);
    }

    /**
     *  code for recommended niches
     */
    //$.post("/user/recommended-niches", {}, function(data, status) {
    //alert(data);

})

/**
 *  code for recommended niches
 */


let recNichesCon = document.querySelector(".recommended-niches");

$.post("/user/recommended-niches", {}, function(data, status) {
    //alert(data);
    let rNiches = JSON.parse(data);
    if (rNiches.length > 0) {
        rNiches.forEach(rNiche => {
            console.log(rNiche);
            recNicheMaker(rNiche);

        });
    } else {
        // show that there are no niches and hide next niches button
        recNichesCon.innerHTML = `
                    <h6 class="p-5"> No Niches Recommended...Yet</h6>
                `;

    }
});

function recNicheMaker(niche) {
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

    menuBtnCon.innerHTML = `<button class="membership-action btn btn-outline-success" style="padding:3% 6%">Join</button>`;
    nFoot.appendChild(menuBtnCon);
    // add data attributes 4 later use on clicking the menuBtnCon to necessary buttons
    menuBtnCon.addEventListener("click", function(event) {
        // remove niche when btn is clicked
        join(event);
        event.target.removeEventListener("click", function(event) {});

        function join(e) {

            $.post("/niche/join-or-leave", {
                "niche-id": menuBtnCon.dataset.nicheId,

            }, function(data, status) {
                //alert(data);
                if (data == 0) {
                    //remove card
                    newNiche.style.display = "none";
                } else {
                    // do 
                    menuBtnCon.textContent = "Joined";
                }


            });
        }


    });


    //
    newNiche.appendChild(nFoot);
    recNichesCon.appendChild(newNiche);

}





/**
 *  code for YOUR NICHES
 */

let yourNichesCon = document.querySelector(".your-niches");
let moreYourNichesBtn = document.querySelector(".yn-btn");
$.post("/user/niches", {
    "starting": 0,
    "amount": 5
}, function(data, status) {
    //alert(data);
    let yNiches = JSON.parse(data);
    if (yNiches.length > 0) {
        yNiches.forEach(yNiche => {
            nicheMaker(yNiche);

        });
        // update next niches position
        moreYourNichesBtn.dataset.nextPos = Number(moreYourNichesBtn.dataset.nextPos) + yNiches.length;
    } else {
        // show that there are no niches and hide next niches button
        yourNichesCon.innerHTML = `
                    <h6 class="p-5"> No Niches Joined BY This Account Owner Yet...</h6>
                `;
        moreYourNichesBtn.style.visibility = "hidden";
    }
});

// more niches
moreYourNichesBtn.addEventListener("click", function() {
    $.post("/user/niches", {
        "starting": moreYourNichesBtn.dataset.nextPos,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        let yNiches2 = JSON.parse(data);
        if (yNiches2.length > 0) {
            yNiches2.forEach(yNiche2 => {
                nicheMaker(yNiche2);

            });
            //update niche position
            moreYourNichesBtn.dataset.nextPos = Number(moreYourNichesBtn.dataset.nextPos) + yNiches2.length;
        } else {
            moreYourNichesBtn.style.visibility = "hidden";
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


    menuBtnCon.innerHTML = `<button class="membership-action btn btn-outline-danger" style="padding:1% 2%">Exit</button>`;
    nFoot.appendChild(menuBtnCon);
    // add data attributes 4 later use on clicking the menuBtnCon to necessary buttons
    menuBtnCon.addEventListener("click", function(event) {
        // remove niche when btn is clicked
        leave(event);

        function leave(e) {

            $.post("/niche/join-or-leave", {
                "niche-id": menuBtnCon.dataset.nicheId,

            }, function(data, status) {
                //alert(data);
                if (data == 0) {
                    //remove card
                    newNiche.style.display = "none";
                } else {
                    // do 
                    menuBtnCon.textContent = "error";
                }


            });
        }


    });


    //
    newNiche.appendChild(nFoot);
    yourNichesCon.appendChild(newNiche);

}