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
 *  fetch data containing the details of this post
 */

$(document).ready(function() {
    $.post("/post/details", {}, function(data, status) {
        alert(data);
        // convert to Js object
        let res = JSON.parse(data);
        if (res != {}) {
            // reference elements
            document.querySelector(".poster #photo").src = `/storage/profile/${res.poster.photo}`;
            let userLink = document.querySelector(".poster .name a");
            userLink.href = `/user/${res.poster.username}`;
            userLink.textContent = res.poster.username;
            document.querySelector(".poster .more .date").textContent = res.date_updated;
            // views
            let views = document.querySelector(".metadata .post-views");
            if (res.views <= 1) {
                views.innerHTML = `<b>${res.views}</b>
                <p>View</p>`;
            } else {
                views.innerHTML = `<b>${res.views}</b>
                <p>Views</p>`;
            }
            // stats of people following, comments
            let postFollowings = document.querySelector(".post-followings");
            let postComments = document.querySelector(".post-comments");
            postFollowings.childNodes[1].textContent = res.followings;
            if (res.followings <= 1) {
                postFollowings.childNodes[3].textContent = "Person Following";
            } else {
                postFollowings.childNodes[3].textContent = "People Following";
            }
            postComments.childNodes[1].textContent = res.comments;
            if (res.comments <= 1) {
                postComments.childNodes[3].textContent = "Comment";
            } else {
                postComments.childNodes[3].textContent = "Comments";
            }
            // niche
            let niche = document.querySelector(".post-stats .niche");
            niche.href = `/niche/${res.category.alias}`;
            niche.textContent = res.category.alias;
            let postThumbnail = document.querySelector(".post-main-pic");
            // if the poster did not attach any photos, use the niche banner instead for the thumbnail

            // any video embedded into post
            let videoFrame = document.querySelector(".video-frame");
            let videoCaption = document.querySelector(".video-caption");


            document.querySelector(".post-title").textContent = res.title;
            let postType = document.querySelector(".content-type");
            postType.href = `/search?ct=${res.content_type.name}`;
            postType.textContent = res.content_type.name;
            document.querySelector(".content").innerHTML = res.content;
            // gallery code
            let galleryCon = document.querySelector(".gallery");
            if (res.photos.length > 1) {
                for (let indexer = 1; indexer < res.photos.length; indexer++) {
                    let pic = res.photos[indexer].path;
                    let galleryImage = document.createElement("img");
                    galleryImage.src = `/storage/post/${pic}`;
                    galleryCon.appendChild(galleryImage);

                }
            } else {
                //
            }
            // prev and next
            if (res.prev != null) {
                // document.querySelector(".prev-and-next").style.display = "block";
                let prev = document.querySelector(".prev-and-next .prev");
                prev.style.display = "block";
                prev.href = res.prev;
            }
            if (res.next != null) {
                let next = document.querySelector(".prev-and-next .next");
                next.style.display = "block";
                next.href = res.next;
            }

            //related posts
            let rPostsCon = document.querySelector(".related-posts-con");
            if (res.related_posts != []) {
                res.related_posts.forEach(rPost => {
                    let newRPost = document.createElement("div");
                    newRPost.setAttribute("class", "userpost bg-light mb-2 ps-2");
                    newRPost.innerHTML = `
                            
                            <article class="content-con">

                                <a href="/post/${rPost.id}/${rPost.slug}" class="title">
                                    ${rPost.title}
                                </a>
                            </article>

                        `;
                    rPostsCon.appendChild(newRPost);

                });
            }
        }
    });

    /**
     *  code to independently fetch post comments
     */
    let commentsContainer = document.querySelector(".comments-section");
    //
    let replyBtns = document.querySelectorAll(".reply-count-btn");
    $.post("/post/comments", {
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        let comments = JSON.parse(data);

        // create comment card
        if (comments.length != 0) {
            comments.forEach(cmt => {
                // create card body
                let card = document.createElement("article");
                card.setAttribute("class", "comment");
                commentsContainer.appendChild(card);
                // card content
                let cardContent = document.createElement("p");
                cardContent.textContent = cmt.content;
                card.appendChild(cardContent);
                // card foot
                let cardFoot = document.createElement("footer");
                cardFoot.setAttribute("class", "meta");
                card.appendChild(cardFoot);
                // user container in foot
                let userInfoCon = document.createElement("div");
                userInfoCon.setAttribute("class", "user");
                cardFoot.appendChild(userInfoCon);
                // image int usercon
                let userPhoto = document.createElement("img");
                userPhoto.src = "/storage/profile/" + cmt.commenter.photo;
                userInfoCon.appendChild(userPhoto);
                // user profile in usercon
                let profileLink = document.createElement("a");
                profileLink.href = "/user/" + cmt.commenter.username;
                profileLink.textContent = cmt.commenter.username;
                userInfoCon.appendChild(profileLink);
                // date in card foot
                let cardDate = document.createElement("span");
                cardDate.setAttribute("class", "comment-date");
                cardDate.textContent = cmt.date_updated;
                cardFoot.appendChild(cardDate);
                // reply stats in card foot
                let cardReplyCon = document.createElement("div");
                cardReplyCon.setAttribute("class", "reply-count-btn text-danger");
                cardReplyCon.setAttribute("data-comment", cmt.id);
                cardReplyCon.setAttribute("data-shown", "0");
                cardReplyCon.innerHTML = `<b>${cmt.replies}</b>
                        <span> Replie(s)</span>`;

                cardFoot.appendChild(cardReplyCon);
                // replies container
                let repliesContainer = document.createElement("aside");
                repliesContainer.setAttribute("class", "replies");
                card.appendChild(repliesContainer);
                // click event on replies count btn
                cardReplyCon.addEventListener("click", function(crc) {
                    //alert(cardReplyCon.dataset.shown)
                    // check whether replies are already fetched and shown or not
                    // fetch & show replies if false
                    if (cardReplyCon.dataset.shown == "0") {
                        $.post("/post/comment/replies", { "comment_id": cmt.id }, function(data, status) {
                            let replies = JSON.parse(data);
                            if (replies != []) {
                                // create reply cards
                                replies.forEach(replyObject => {
                                    let reply = document.createElement("div");
                                    reply.setAttribute("class", "reply btn-light mb-2 p-1 mt-2");
                                    reply.innerHTML = `
                                        <p class="body">${replyObject.content}</p>
                                        <span style="font-size: 0.7rem;">${replyObject.date}</span> --- <a href="/user/${replyObject.replyer.username}" class="replyer">${replyObject.replyer.username}</a>
                                    `;
                                    repliesContainer.appendChild(reply);
                                });
                            }
                        });
                        crc.target.dataset.shown = "1";
                    }
                });

            });
        } else {

            commentsContainer.innerHTML = "<h3 class='p-4'> No Comments Yet...</h3>";
        }

    });





});