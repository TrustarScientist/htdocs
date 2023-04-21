setTimeout(() => {
    $(".sitewide-loader").fadeOut("fast");
    $(".dcol:nth-child(2)").fadeToggle("slow");
    $(".dcol:nth-child(3)").fadeToggle("slow");
    $(".related-posts-con .post-chain-btn").click(function() {
        $(".related-posts-con .post-chain-posts").fadeToggle("slow").css("display", "flex");
    });
    // comment section vs relted posts section control code
    $(".details-paths .comments").click(function(e) {
        e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
        document.querySelector(".details-paths .related-posts").style.borderBottom = "0";
        $(".comment-section").fadeIn("fast")
        $(".related-posts-section").fadeOut("fast")
    });
    $(".details-paths .related-posts").click(function(e) {
        e.target.style.borderBottom = "2px solid rgb(13, 139, 77)";
        document.querySelector(".details-paths .comments").style.borderBottom = "0";
        $(".comment-section").fadeOut("fast")
        $(".related-posts-section").fadeIn("fast")
    });
    // comment add toggle
    $(".comment-add-btn").click(function() {
        $(".comment-form").fadeToggle("slow")
    });

    /**
     *  code to load post details
     *  firstly, we need to parse the URL and get the post id
     */


    let postId = /[\/\w:\d\.]+\/(\d+)/.exec(window.location.href)
        // let postPoster = 0;
        // let postNiche = 0;
    if (postId != null) {
        // continue processing
        $.post("/post/pvt/details", {
            "postid": postId[1]
        }, function(data, status) {
            //alert(data)
            let pdetailsObj = JSON.parse(data);
            let postTitle = document.querySelector(".post-title");
            postTitle.textContent = pdetailsObj.title;
            document.querySelector(".poster .photo").src = `/storage/profile/${pdetailsObj.poster.photo}`;
            document.querySelector(".poster .more .username").textContent = pdetailsObj.poster.username;
            document.querySelector(".poster .more .username").href = `/user/${pdetailsObj.poster.username}`;
            document.querySelector(".poster .more .date").textContent = pdetailsObj.date_updated;
            document.querySelector(".ctype").textContent = pdetailsObj.content_type.name;
            document.querySelector(".post-stats .views b").textContent = pdetailsObj.views;
            document.querySelector(".post-stats .following b").textContent = pdetailsObj.following;
            document.querySelector(".post-stats .comments b").textContent = pdetailsObj.comments;
            let postCategory = document.querySelector(".poster-details .category");
            postCategory.textContent = pdetailsObj.category.alias;
            postCategory.href = `/niche/${pdetailsObj.category.alias}`;
            // post edit option
            if (pdetailsObj.owned_by_cuser) {
                let pDEBtn = document.querySelector(".post-details-edit-btn")
                pDEBtn.style.display = "inline";
                pDEBtn.href = `/post/edit?action=update&postid=${pdetailsObj.id}`;
            }
            // content
            document.querySelector(".post-content").innerHTML = pdetailsObj.content;

            /**
             *  related posts:
             *  some from the poster
             *  many from the current post category niche
             */
            let upostsContainer = document.querySelector(".userposts");

            $.post("/user/posts", {
                "profile_id": pdetailsObj.poster.id,
                "starting": 0,
                "amount": 4
            }, (data, status) => {
                //alert(data);
                let uPosts = JSON.parse(data);
                if (uPosts.length > 0) {
                    uPosts.forEach(upost => {
                        if (upost.postid != pdetailsObj.id) {
                            postBuilder(upost, upostsContainer);
                        }
                    });
                }

            });

            $.post("/niche/pvt/posts", {
                "niche-id": pdetailsObj.category.id,
                "starting": 0,
                "amount": 3
            }, (data, status) => {
                let nichePosts = JSON.parse(data);
                if (nichePosts.length > 0) {
                    nichePosts.forEach(nichePost => {
                        if (nichePost.postid != pdetailsObj.id) {
                            postBuilder(nichePost, upostsContainer);
                        }
                    });
                }
            });
        });
    } else {
        window.location.assign("/404");
    }
    /**
     *  comment adding functionality
     */

    let commentAddBody = document.querySelector(".comment-add-form #body");
    console.log(commentAddBody)
    commentAddBody.value = "Add your comment here...";
    commentAddBody.dataset.state = "0";
    commentAddBody.onclick = (e) => {
        // to remove default text...when clicked for the first time
        if (e.target.dataset.state == "0") {
            e.target.value = "";
            e.target.dataset.state = "1";
        }
    };
    // form submission btn
    let commentAddFormBtn = document.querySelector(".comment-add-form .submit");
    // form submission
    let commentAddForm = document.querySelector(".comment-add-form");
    commentAddForm.addEventListener("submit", (cafEvent) => {
            cafEvent.preventDefault();
            if ((commentAddBody.value != '') && (commentAddBody.value != "Add your comment here...")) {
                $.post("/post/comment/add", {
                    "content": commentAddBody.value,
                    "postid": postId[1]
                }, function(data, status) {
                    //alert(data);
                    if (data == "1") {
                        // change comment box state
                        commentAddBody.dataset.state = "0";
                        commentAddFormBtn.textContent = "Add New Comment...";

                    } else {
                        commentAddFormBtn.textContent = "Comment Not Added...Sorry";
                    }
                });
            }
        })
        /**
         *  post comments fetching code
         */
    let commentsSection = document.querySelector(".post-comment-section");
    let moreCommentsBtn = document.querySelector(".more-comments-btn");
    $.post("/post/comments", {
        "starting": 0,
        "amount": 5
    }, (data, status) => {
        //alert(data);
        let postComments = JSON.parse(data);
        if (postComments.length > 0) {
            postComments.forEach(pComment => {
                commentCreator(pComment)
            });
            moreCommentsBtn.dataset.mc = Number(moreCommentsBtn.dataset.mc) + postComments.length;


        } else {
            // display that no comments
            commentsSection.innerHTML = `<h4 class="p-5">No Comments...Yet</h4>`;
            moreCommentsBtn.style.display = "none";
        }
    })

    // more comments
    moreCommentsBtn.addEventListener("click", (mcEvent) => {
        //alert(mcEvent.target.dataset.mc)
        $.post("/post/comments", {
            "starting": mcEvent.target.dataset.mc,
            "amount": 5
        }, (data, status) => {
            //alert(data);
            let postComments2 = JSON.parse(data);
            if (postComments2.length > 0) {
                postComments2.forEach(pComment2 => {
                    commentCreator(pComment2)
                });
                moreCommentsBtn.dataset.mc = Number(moreCommentsBtn.dataset.mc) + postComments2.length;


            } else {
                // display none morecomments button
                moreCommentsBtn.style.display = "none";
            }
        })
    })

    // comment card creator
    function commentCreator(comment) {
        let cCard = document.createElement("article");
        cCard.setAttribute("class", "post-comment-section comment");
        cCard.innerHTML = "";
        let replyState = "Reply";
        if (comment.replies > 1) {
            replyState = "Replies";
        }

        cCard.innerHTML = `
        <p class="body">${comment.content}</p>
        <footer class="commenter-con">
                            <div class="commenter">
                                <img class="pic" src="/storage/profile/${comment.commenter.photo}" alt="commenter photo">
                                <p class="metadata">
                                    <a href="/user/${comment.commenter.username}" class="username">${comment.commenter.username}</a>
                                    <b class="dot">&dot;</b>
                                    <span class="date">${comment.date_updated}</span>
                                </p>
                            </div>
                            <aside class="reply-count" data-state="0">
                                <b>${comment.replies}</b>
                                <span>${replyState}</span>

                            </aside>
                        </footer>
                        <div class="replies-con">
                            <article class="reply">
                                <p class="body">This is areply for the comment above...ok?</p>
                                <a href="/user/Phychemma" class="replyer">Phychemma</a>
                                <span class="date">date</span>
                            </article>
                            <article class="reply">
                                <p class="body">This is the second sample reply for the comment above...ok?</p>
                                <a href="/user/Phychemma" class="replyer">Phychemma</a>
                                <span class="date">date</span>
                            </article>
                        </div>
                        <form action="" method="post" class="reply-form" data-cid="0">
                            <input type="text" name="reply-message" id="rm" class="form-control" placeholder="reply to this comment...">
                            <button class="btn btn-light" type="submit">Reply...</button>
                        </form>
                `;
        // the reply form submission code
        let replyForm = cCard.childNodes[7];
        replyForm.dataset.cid = comment.id;

        replyForm.addEventListener("submit", (replyFormEvent) => {
            replyFormEvent.preventDefault();
            $.post("/post/comment/replies/add", {
                "cid": replyForm.dataset.cid,
                "reply-body": replyForm.childNodes[1].value
            }, (data, status) => {
                //alert(data);
                if (data == "1") {
                    replyForm.childNodes[1].value = "";
                    replyForm.childNodes[3].textContent = "Reply Saved";
                    setTimeout(() => {
                        replyForm.childNodes[3].textContent = "Add Reply...";
                    }, 1000);
                } else if (data == "0") {
                    replyForm.childNodes[3].textContent = "Not Saved...";
                } else {
                    replyForm.childNodes[3].textContent = "Error...";
                }
            });
        })
        let replyCount = cCard.childNodes[3].childNodes[3];
        cCard.childNodes[3].childNodes[3];
        replyCount.dataset.cid = comment.id;

        replyCount.addEventListener("click", (e) => {
            if (replyCount.dataset.state == "0") {
                replyCount.parentNode.parentNode.childNodes[5].innerHTML = "";
                $.post("/post/comment/replies", {
                    "comment_id": replyCount.dataset.cid
                }, (data, status) => {
                    //alert(data);
                    let commentReplies = JSON.parse(data);
                    if (commentReplies.length > 0) {
                        commentReplies.forEach(comRep => {
                            replyCreator(comRep)
                        });
                        replyCount.dataset.state = 1;
                    }
                });
            }
        })
        commentsSection.appendChild(cCard);

        function replyCreator(reply) {
            let rep = document.createElement("div");
            rep.setAttribute("class", "reply");
            rep.innerHTML = `
                <p> <b class="content">${reply.content}</b> </p>
                <p class="info"> <a href="/user/${reply.replyer.username}">${reply.replyer.username}</a> <b>.</b> <span>${reply.date}</span></p>
            `;
            (replyCount.parentNode.parentNode.childNodes[5].appendChild(rep))
            replyCount.parentNode.parentNode.childNodes[5].style.display = "block";

        }
    }


}, 500);