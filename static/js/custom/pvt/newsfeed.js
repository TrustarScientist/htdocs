$(document).ready(function() {
    /**
     *  recommeded people and current user reaction functions such as liking, sending friend request or blocking
     */
    $.get("/user/recommended-people", function(data, status) {
        //alert(data);
        let rpsection = document.querySelector(".recommended-people-section");

        let peopleContainer = document.querySelector(".rp-container .scroller");

        let people = JSON.parse(data);
        if (people != "") {
            people.forEach(person => {
                // create new person
                let newPerson = document.createElement("div");
                newPerson.setAttribute("class", "person");
                let is_liked_color = "";
                if (person.is_liked == 1) {
                    is_liked_color = "deeppink";
                }
                let likeIcon = document.createElement("header");
                likeIcon.setAttribute("class", "like-icon");
                likeIcon.dataset.pid = person.id;
                likeIcon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="${is_liked_color}" class="bi bi-heart" viewBox="0 0 16 16">
                    <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                    </svg>`;
                newPerson.appendChild(likeIcon);
                // toggle like states
                likeIcon.addEventListener("click", function(e) {
                    $.post("/user/likeness", {
                        "liked": likeIcon.dataset.pid
                    }, function(data, status) {
                        if (data == "created") {
                            likeIcon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="deeppink" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                            </svg>`;
                        } else {
                            likeIcon.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-heart" viewBox="0 0 16 16">
                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                            </svg>`;
                        }
                    })
                });
                peopleContainer.appendChild(newPerson);
                // image
                let photo = document.createElement("img");
                photo.setAttribute("class", "image");
                photo.src = `/storage/profile/${person.photo}`;
                newPerson.appendChild(photo);
                //username
                let username = document.createElement("a");
                username.href = `/user/${person.username}`;
                username.textContent = person.username;
                newPerson.appendChild(username);
                // display
                rpsection.style.display = "block";
            });
        } else {
            // rpsection.style.display = "none";
        }
    });



    /**
     *  We need to fetch personalized posts based on the community
     *  the current user is a member or just the posts the root niche if current
     *  user does not belong to any Niche
     */


    let postsContainer = document.querySelector(".userposts");
    let morePersonalizedPostsBtn = document.querySelector(".mpp");
    $.post("/post/newsfeed", {
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        // convert to Js Object
        // next posts starting point

        let res = JSON.parse(data);
        if (res != []) {
            res.forEach(post => {
                //alert(post);
                postCreator(post, postsContainer, morePersonalizedPostsBtn);
            });

        }
    });
    /** 
     *  Next posts starting point button
     */
    morePersonalizedPostsBtn.onclick = function(e) {
            $.post("/post/newsfeed", {
                "starting": e.target.dataset.mpp,
                "amount": 5
            }, function(data, status) {
                //alert(data);
                // convert to Js Object
                // next posts starting point

                let res = JSON.parse(data);
                if (res != []) {
                    res.forEach(post => {
                        postCreator(post, postsContainer, morePersonalizedPostsBtn);
                    });

                }
            });
        }
        /** 
         *  code to follow or unfollow posts
         *  we gat to loop through all post follow icons and add click event listening code to them...each
         */


    //helper function
    function postCreator(post, container, nextPostsBtn = {}) {

        // create new post element
        let userpost = document.createElement("article");
        userpost.setAttribute("class", "userpost");
        // append into posts container
        container.appendChild(userpost);
        // create thumbnail if available
        if (post.thumbnail != "") {
            let thumbnail = document.createElement("img");
            thumbnail.setAttribute("class", "post-thumbnail");
            thumbnail.src = `/storage/post/${post.thumbnail}`;
            //alert(post.thumbnail);
            userpost.appendChild(thumbnail);
        }
        // post title
        let title = document.createElement("a");
        title.setAttribute("class", "title");
        title.href = `/post/${post.postid}/${post.slug}`;
        title.textContent = post.title;
        userpost.appendChild(title);
        // metadata container
        let metadata = document.createElement("footer");
        metadata.setAttribute("class", "metadata mt-3 mb-1");
        userpost.appendChild(metadata);
        //user metadata con
        let userInfoCon = document.createElement("section");
        userInfoCon.setAttribute("class", "user-info");
        metadata.appendChild(userInfoCon);
        // poster photo
        let userPhoto = document.createElement("img");
        userPhoto.setAttribute("class", "photo");
        userPhoto.src = `/storage/profile/${post.poster.photo}`;
        userInfoCon.appendChild(userPhoto);
        // misc user info
        let udCon = document.createElement("div");
        udCon.setAttribute("class", "ud");
        userInfoCon.appendChild(udCon);
        // username in udCon
        let uName = document.createElement("a");
        uName.setAttribute("class", "username");
        uName.href = `/user/${post.poster.username}`;
        uName.textContent = post.poster.username;
        udCon.appendChild(uName);
        // date in udCon
        let uDate = document.createElement("aside");
        uDate.setAttribute("class", "date");
        uDate.textContent = post.date;
        udCon.appendChild(uDate);
        //stats con
        let statsCon = document.createElement("section");
        statsCon.setAttribute("class", "stats");
        metadata.appendChild(statsCon);
        // the state showing whether the current user has started following the post already
        let fState = "black";
        if (post.current_user_has_followed == 1) {
            fState = "deeppink";
        }
        // following con 
        let fCon = document.createElement("div");
        fCon.setAttribute("class", "following-con");
        fCon.dataset.postfollowed = post.postid;
        fCon.innerHTML = `
            <svg style="fill: ${fState};"  xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-heart follow-icon" viewBox="0 0 16 16">
            <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/> </svg>
            <aside class="count" >${post.followings} +</aside>
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
                } else if (data == "deleted") {
                    // change to black
                    fCon.childNodes[1].style.fill = "black";
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
            <aside class="count">${post.comment_count}</aside>
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
        postMenu.innerHTML = `
                <svg xmlns="http://www.w3.org/­2000/svg" data-bs-toggle="modal" data-bs-target="#myModal" width="20" height="20" fill="currentColor" class="bi bi-three-dots-vertic­al" viewBox="0 0 16 16"> <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/> </svg>       
            `;
        statsCon.appendChild(postMenu);
        postMenu.addEventListener("click", function() {
            /**
             *  block or release the user who posted this post
             */
            // first toggle membership state from the backend
            let blacklistBtn = document.querySelector(".block-or-unblock-poster");
            blacklistBtn.childNodes[2].textContent = " " + post.poster.username;
            if (post.poster_blocked) {

                blacklistBtn.childNodes[0].textContent = "Unblock";
            } else {
                blacklistBtn.childNodes[0].textContent = "Block";
            }
            // user to block as data attribute
            blacklistBtn.dataset.utob = post.poster.id;

            // blacklistBtn.addEventListener("click", function() {
            //     $.post("/user/blacklist", { "user_to_block": post.poster.id }, function(data, status) {
            //         alert(data);
            //     });
            // });
        });
        nextPostsBtn.dataset.mpp = (Number(nextPostsBtn.dataset.mpp) + 1);
        /**
         *  extra code
         */
        let blockingBtn = document.querySelector(".block-or-unblock-poster");
        blockingBtn.onclick = function(e) {
            $.post("/user/blacklist", { "user_to_block": blockingBtn.dataset.utob }, function(data, status) {
                alert(data);
            });
        }

    }

});