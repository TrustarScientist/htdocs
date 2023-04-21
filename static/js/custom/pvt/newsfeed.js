let swLoader = document.querySelector(".sitewide-loader");

setTimeout(() => {

    $(document).ready(function() {
        swLoader.style.display = "none";
        $(".dcol:nth-child(2)").fadeIn("slow");

        /**
         *  fetch top ranking niches
         */

        $.get("/niche/toprank", function(data, status) {
            //alert(data);
            let topNiches = JSON.parse(data);
            if (topNiches.length > 0) {
                topNiches.forEach(tNiche => {
                    let nicheLink = document.createElement("a");
                    nicheLink.setAttribute("class", "pniche");
                    nicheLink.textContent = "";
                    nicheLink.textContent = tNiche.alias;
                    nicheLink.href = `/niche/${tNiche.alias}`;
                    document.querySelector(".pn-con .popular-niches").appendChild(nicheLink);
                });
            }
        })



        /**
         * code to fetch personalized posts
         */
        let userpostsCon = document.querySelector(".userposts-section .userposts");
        let morePPost = document.querySelector(".more-p-posts");
        $.post("/post/newsfeed", {
            "starting": 0,
            "amount": 12
        }, function(data, status) {
            //alert(data);
            let posts = JSON.parse(data);
            if (posts.length > 0) {
                posts.forEach(post => {
                    if (post.cuser_is_member) {
                        if (!post.poster_blocked) {
                            postBuilder(post)
                        }
                    }
                });
                morePPost.style.display = "block";
                morePPost.dataset.nextPpos = Number(morePPost.dataset.nextPpos) + posts.length;
            } else {
                userpostsCon.innerHTML = `<h6 class="p-5"> No Posts For You Yet...`;
                morePPost.style.display = "none";
            }
        });

        // next personalized posts
        morePPost.addEventListener("click", function(e) {
            //alert(e.target.dataset.nextPpos)
            $.post("/post/newsfeed", {
                "starting": morePPost.dataset.nextPpos,
                "amount": 12
            }, function(data, status) {
                //alert(data);
                let posts2 = JSON.parse(data);
                if (posts2.length > 0) {
                    posts2.forEach(p2 => {
                        if (p2.cuser_is_member) {
                            if (!p2.poster_blocked) {
                                postBuilder(p2)
                            }
                        }
                    });
                    morePPost.dataset.nextPpos = Number(morePPost.dataset.nextPpos) + posts2.length;
                } else {
                    morePPost.style.display = "none";
                }
            });
        });
        // helper function 2
        function postBuilder(post) {
            //alert(post.is_member);
            let postCard = document.createElement("article");
            // if (!post.is_member) {
            //     postCard.setAttribute("style", "display:none");
            // } else {
            //     postCard.setAttribute("style", "display:block");
            // }
            postCard.setAttribute("class", "userpost");
            //
            let mainPImgShower = "none";
            if (post.pic.length > 0) {
                mainPImgShower = "inline";
            }
            postCard.innerHTML = `
                <header class="head">
                    <a href="/search?ct=${post.contenttype}" class="niche-name ">${post.contenttype}</a>
                    <a href="/niche/${post.niche.alias}" class="content-type">${post.niche.alias}</a>
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

        // // helper function to create post cards
        // function postCreator(post) {

        //     // create new post element
        //     let userpost = document.createElement("article");
        //     userpost.setAttribute("class", "userpost");
        //     // append into posts container
        //     userpostsCon.appendChild(userpost);
        //     //create post head
        //     let head = document.createElement("header");
        //     head.setAttribute("class", "middle");
        //     userpost.appendChild(head);
        //     // create thumbnail if available

        //     if (post.pic == "") {
        //         let thumbnail = document.createElement("img");
        //         thumbnail.setAttribute("class", "post-thumbnail");
        //         thumbnail.src = `/storage/post/alimat-pic1.jpg`;
        //         //alert(post.thumbnail);
        //         head.appendChild(thumbnail);
        //     }
        //     // post title
        //     let title = document.createElement("a");
        //     title.setAttribute("class", "title");
        //     title.href = `/post/${post.postid}/${post.slug}`;
        //     title.textContent = post.title;
        //     head.appendChild(title);
        //     // metadata container
        //     let metadata = document.createElement("footer");
        //     metadata.setAttribute("class", "metadata mb-1");
        //     userpost.appendChild(metadata);
        //     //user metadata con
        //     let userInfoCon = document.createElement("section");
        //     userInfoCon.setAttribute("class", "user-info");
        //     metadata.appendChild(userInfoCon);
        //     // poster photo
        //     let userPhoto = document.createElement("img");
        //     userPhoto.setAttribute("class", "photo");
        //     userPhoto.src = `/storage/profile/${post.user.photo}`;
        //     userInfoCon.appendChild(userPhoto);
        //     // misc user info
        //     let udCon = document.createElement("div");
        //     udCon.setAttribute("class", "ud");
        //     userInfoCon.appendChild(udCon);
        //     // username in udCon
        //     let uName = document.createElement("a");
        //     uName.setAttribute("class", "username");
        //     uName.href = `/user/${post.user.username}`;
        //     uName.textContent = post.user.username;
        //     udCon.appendChild(uName);
        //     // date in udCon
        //     let uDate = document.createElement("aside");
        //     uDate.setAttribute("class", "date");
        //     uDate.textContent = post.updated;
        //     udCon.appendChild(uDate);
        //     //stats con
        //     let statsCon = document.createElement("section");
        //     statsCon.setAttribute("class", "stats");
        //     metadata.appendChild(statsCon);
        //     // the state showing whether the current user has started following the post already
        //     let fState = "black";
        //     if (post.c_user_has_followed > 0) {
        //         fState = "deeppink";
        //     }
        //     // following con 
        //     let fCon = document.createElement("div");
        //     fCon.setAttribute("class", "following-con");
        //     fCon.dataset.postfollowed = post.postid;
        //     fCon.innerHTML = `
        //     <svg style="fill: ${fState};"  xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="" class="bi bi-heart follow-icon" viewBox="0 0 16 16">
        //     <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
        //     </svg>
        //     <aside class="count" >${post.following}</aside>
        // `;
        //     statsCon.appendChild(fCon);
        //     // control post following
        //     fCon.addEventListener("click", function() {
        //         // check & update user for  post following state. it is a flipflop thing
        //         // follow unless the user is already following....then stop following.
        //         $.post("/post/following", {
        //             "post_id": fCon.dataset.postfollowed
        //         }, function(data, status) {
        //             //alert(data)
        //             if (data == "created") {
        //                 // change icon fill to reddish...

        //                 fCon.childNodes[1].style.fill = "deeppink";
        //                 fCon.childNodes[1].innerHTML = `<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>`;
        //                 fCon.childNodes[3].innerHTML = Number(fCon.childNodes[3].innerHTML) + 1;
        //             } else if (data == "deleted") {
        //                 // change to black
        //                 fCon.childNodes[1].style.fill = "grey";
        //                 fCon.childNodes[3].innerHTML = Number(fCon.childNodes[3].innerHTML) - 1;
        //             } else {
        //                 // do nothing
        //             }
        //         });
        //     });
        //     // comments con
        //     let cCon = document.createElement("div");
        //     cCon.setAttribute("class", "comments-con");
        //     cCon.innerHTML = `
        //     <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat" viewBox="0 0 16 16">
        //     <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z"/>
        //     </svg>
        //     <aside class="count">${post.comments}</aside>
        // `;
        //     statsCon.appendChild(cCon);
        //     //views-con
        //     let vCon = document.createElement("div");
        //     vCon.setAttribute("class", "views-con");
        //     vCon.innerHTML = `
        //     <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
        //     <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
        //     </svg>
        //     <aside class="count">${post.views}</aside>
        // `;
        //     statsCon.appendChild(vCon);

        //     // post options menu
        //     let postMenu = document.createElement("div");
        //     postMenu.dataset.postid = post.postid;
        //     postMenu.dataset.postSlug = post.slug;
        //     postMenu.innerHTML = `
        //         <svg xmlns="http://www.w3.org/­2000/svg" data-bs-toggle="modal" data-bs-target="#postModal" width="20" height="20" fill="currentColor" class="bi bi-three-dots-vertic­al" viewBox="0 0 16 16"> <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/> </svg>       
        //     `;
        //     statsCon.appendChild(postMenu);
        //     postMenu.addEventListener("click", function() {
        //         //pass data
        //         let shareBtn = document.querySelector(".modal .share-btn");
        //         shareBtn.dataset.postId = postMenu.dataset.postid;
        //         shareBtn.dataset.postSlug = postMenu.dataset.postSlug;
        //         shareBtn.textContent = "Share Post...";
        //         shareBtn.addEventListener("click", shareMgr);

        //         function shareMgr(e) {
        //             navigator.share({
        //                 title: e.target.dataset.postSlug,
        //                 text: window.location.href,
        //                 ulr: `/post/${post.postid}/${post.slug}`
        //             }).then(
        //                 () => e.target.textContent = "Post Shared...",
        //                 (error) => e.target.textContent = "Post not shared"
        //             );
        //         }
        //     });


        // }




    });
}, 500);