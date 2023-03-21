$(document).ready(function() {
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

    $.post("/post/newsfeed", {
        "starting": 0,
        "amount": 100
    }, function(data, status) {
        alert(data);
        let posts = JSON.parse(data);
        if (posts.length > 0) {
            posts.forEach(post => {
                postCreator(post);
            });
        }
    });


    // helper function to create post cards
    function postCreator(post) {

        // create new post element
        let userpost = document.createElement("article");
        userpost.setAttribute("class", "userpost");
        // append into posts container
        userpostsCon.appendChild(userpost);
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




});