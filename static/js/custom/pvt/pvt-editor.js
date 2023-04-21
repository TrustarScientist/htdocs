setTimeout(() => {
    // display dcol
    document.querySelector(".dcol:nth-child(2)").style.display = "block";
    document.querySelector(".dcol:nth-child(3)").style.display = "block";
    /** code to toggle between self posts section and editor section */
    function getDeviceWidth() {
        return window.innerWidth;
    }
    if (getDeviceWidth() < 992) {
        $(".your-posts-display-btn").click(function() {
            $(".content-area").fadeOut("slow");
            $(".userposts2edit-con").fadeIn("slow");
        })
        $(".self-posts-cancel-icon").click(function() {
            $(".userposts2edit-con").fadeOut("slow");
            $(".content-area").fadeIn("slow");
        });

    }

    // current user's niches
    $.post("/user/niches", {
        "starting": 0,
        "amount": 1000000
    }, function(data, status) {
        //alert(data);
        let postCategorySelection = document.querySelector("#post-category");
        let niches = JSON.parse(data);
        niches.forEach(niche => {
            let option = document.createElement("option");
            option.value = niche.id;
            option.textContent = niche.alias;
            postCategorySelection.appendChild(option);

        });

    })



    /** 
     * 
     * editor coode 
     * 
     * */
    let editor;

    class MyUploadAdapter {
        constructor(loader) {
            // The file loader instance to use during the upload.
            this.loader = loader;
        }

        // Starts the upload process.
        upload() {
            return this.loader.file
                .then(file => new Promise((resolve, reject) => {
                    this._initRequest();
                    this._initListeners(resolve, reject, file);
                    this._sendRequest(file);
                }));
        }

        // Aborts the upload process.
        abort() {
            if (this.xhr) {
                this.xhr.abort();
            }
        }

        // Initializes the XMLHttpRequest object using the URL passed to the constructor.
        _initRequest() {
            const xhr = this.xhr = new XMLHttpRequest();

            // Note that your request may look different. It is up to you and your editor
            // integration to choose the right communication channel. This example uses
            // a POST request with JSON as a data structure but your configuration
            // could be different.
            xhr.open('POST', '/post/editor/image/upload', true);
            xhr.responseType = 'json';
        }

        // Initializes XMLHttpRequest listeners.
        _initListeners(resolve, reject, file) {
            const xhr = this.xhr;
            const loader = this.loader;
            const genericErrorText = `Couldn't upload file: ${ file.name }.`;

            xhr.addEventListener('error', () => reject(genericErrorText));
            xhr.addEventListener('abort', () => reject());
            xhr.addEventListener('load', () => {
                const response = xhr.response;

                // This example assumes the XHR server's "response" object will come with
                // an "error" which has its own "message" that can be passed to reject()
                // in the upload promise.
                //
                // Your integration may handle upload errors in a different way so make sure
                // it is done properly. The reject() function must be called when the upload fails.
                if (!response || response.error) {
                    return reject(response && response.error ? response.error.message : genericErrorText);
                }

                // If the upload is successful, resolve the upload promise with an object containing
                // at least the "default" URL, pointing to the image on the server.
                // This URL will be used to display the image in the content. Learn more in the
                // UploadAdapter#upload documentation.
                resolve({
                    default: response.url
                });
            });

            // Upload progress when it is supported. The file loader has the #uploadTotal and #uploaded
            // properties which are used e.g. to display the upload progress bar in the editor
            // user interface.
            if (xhr.upload) {
                xhr.upload.addEventListener('progress', evt => {
                    if (evt.lengthComputable) {
                        loader.uploadTotal = evt.total;
                        loader.uploaded = evt.loaded;
                    }
                });
            }
        }

        // Prepares the data and sends the request.
        _sendRequest(file) {
            // Prepare the form data.
            const data = new FormData();

            data.append('upload', file);

            // Important note: This is the right place to implement security mechanisms
            // like authentication and CSRF protection. For instance, you can use
            // XMLHttpRequest.setRequestHeader() to set the request headers containing
            // the CSRF token generated earlier by your application.

            // Send the request.
            this.xhr.send(data);
        }
    }

    function MyCustomUploadAdapterPlugin(editor) {
        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
            // Configure the URL to the upload script in your back-end here!
            return new MyUploadAdapter(loader);
        };
    }

    ClassicEditor
        .create(document.querySelector('#ckeditor'), {
            extraPlugins: [MyCustomUploadAdapterPlugin],

            // More configuration options.
            // ...
            mediaEmbed: {
                previewsInData: true
            }
        })
        .then((newEditor) => {
            editor = newEditor;
        })
        .catch(error => {
            console.log(error);
        });


    /**
     *  query string passed to script determines what the editor should do
     *  creating new post or updating post
     */
    let params = new URL(window.location.href);
    let operationType = (params.searchParams.get("action") != null) ? params.searchParams.get("action") : "create"; // default
    let post2UpdateId = (params.searchParams.get("postid") != null) ? params.searchParams.get("postid") : 0;
    let editorDataBtn = document.querySelector("#editor-data-btn");
    editorDataBtn.dataset.postid = 0;
    editorDataBtn.dataset.postid = 0;
    if (operationType == "create") {
        editorDataBtn.dataset.ot = "create";
        editorDataBtn.textContent = "Create New Post...";

    } else {
        editorDataBtn.dataset.ot = "update";
        editorDataBtn.dataset.postid = post2UpdateId;
        editorDataBtn.textContent = "Update Your Post...";
        /**
         *   code to fetch the data of the post to update
         *   get post id from URL
         *   
         */

        $.post("/post/editor/post2edit", {
            "post2edit": editorDataBtn.dataset.postid
        }, function(data, status) {
            //alert(data);
            let p2eData = JSON.parse(data);
            if (p2eData != []) {
                editor.setData(p2eData.content);
                document.querySelector("#post-title").value = p2eData.title;
                document.querySelector("#post-type").value = p2eData.content_type;
                document.querySelector("#post-visibility").value = p2eData.visibility;
                document.querySelector("#post-category").value = p2eData.category;

            } else if (p2eData == []) {
                /**
                 *  post to update not found
                 *  give option to create new post
                 */
                editorDataBtn.textContent = "Post Not Found...Create New Post Instead";
                editorDataBtn.dataset.ot = "create";

            }
        })

    }




    // to send post data to backend

    editorDataBtn.addEventListener("click", function(e) {
        const postVisibility = document.querySelector("#post-visibility").value;
        const postType = document.querySelector("#post-type").value;
        const postCategory = document.querySelector("#post-category").value;
        const postTitle = document.querySelector("#post-title").value;
        const postContent = editor.getData();
        //alert(postContent);

        if ((e.target.dataset.ot == "create") && postTitle != "") {
            $.post("/post/editor/create-post", {
                "visibility": postVisibility,
                "type": postType,
                "category": postCategory,
                "title": postTitle,
                "content": postContent
            }, function(data, status) {
                //alert(data);
                if (data == "1") {
                    e.target.textContent = "Post Saved";
                    setTimeout(() => {
                        location.assign("/post/edit");
                    }, 1000);
                } else {
                    e.target.textContent = "Something went wrong...post not saved";
                }
            });
        } else if (e.target.dataset.ot == "update") {
            $.post("/post/editor/update-post", {
                "postid": e.target.dataset.postid,
                "visibility": postVisibility,
                "type": postType,
                "category": postCategory,
                "title": postTitle,
                "content": postContent
            }, function(data, status) {
                //alert(data);
                if (data == "1") {
                    e.target.textContent = "Post Updated";
                    setTimeout(() => {
                        location.assign("/post/edit");
                    }, 1000);
                } else {
                    e.target.textContent = "Something went wrong...post not updated";
                }
            });
        }

    });


    /** 
     *  code to fetch current user's posts
     */
    let moreSelfPostsBtn = document.querySelector(".more-self-posts-btn");

    let selfPostsContainer = document.querySelector(".self-posts");
    $.post("/post/editor/posts", {
        "starting": 0,
        "amount": 5
    }, function(data, status) {
        //alert(data);
        let postData = JSON.parse(data);
        if (postData.length > 0) {

            postData.forEach(pd => {
                selfPostMaker(pd);
            });
            document.querySelector(".sitewide-loader").style.display = "none";
            moreSelfPostsBtn.dataset.pos = Number(moreSelfPostsBtn.dataset.pos) + postData.length;
        } else {
            // show that current user does not have any posts to update
            selfPostsContainer.innerHTML = `<h3 class="p-5">You Do Not Have Any Posts...Yet<h3>`;
            moreSelfPostsBtn.style.display = "none";

        }
    });

    moreSelfPostsBtn.addEventListener("click", function(e) {
        $.post("/post/editor/posts", {
            "starting": e.target.dataset.pos,
            "amount": 5
        }, function(data, status) {
            //alert(data);
            let postData2 = JSON.parse(data);
            if (postData2.length > 0) {
                postData2.forEach(pd2 => {
                    selfPostMaker(pd2);
                });
                e.target.dataset.pos = Number(e.target.dataset.pos) + postData2.length;
            } else {
                // hide next posts btn
                e.target.style.display = "none";
            }
        });
    });



    // helper function
    function selfPostMaker(object) {
        let selfPost = document.createElement("article");
        selfPost.setAttribute("class", "self-post");
        selfPost.innerHTML = `<a href="/post/${object.id}/${object.slug}" class="title">
                                ${object.title}
                            </a> `;
        let contentType = document.createElement("a");
        contentType.setAttribute("class", "content-type");
        contentType.href = "/search?ct=" + object.content_type.name;
        contentType.textContent = object.content_type.name;
        selfPost.appendChild(contentType);
        document.querySelector(".self-posts").appendChild(selfPost);
        let footer = document.createElement("footer");
        footer.setAttribute("class", "foot");
        selfPost.appendChild(footer);
        let footBtns = document.createElement("header");
        footBtns.setAttribute("class", "controllers");
        footer.appendChild(footBtns);
        let updateBtn = document.createElement("button");
        updateBtn.setAttribute("class", " update-btn ");
        updateBtn.addEventListener("click", (updateE) => {
            // for mobile screen
            if (getDeviceWidth() < 992) {
                $(".userposts2edit-con").fadeOut("slow");
                $(".content-area").fadeIn("slow");

            }
            // processing
            editorDataBtn.dataset.ot = "update";
            editorDataBtn.dataset.postid = object.id;
            editorDataBtn.textContent = "Update This Post...";

            $.post("/post/editor/post2edit", {
                "post2edit": editorDataBtn.dataset.postid
            }, function(data, status) {
                //alert(data);
                let p2UpdateData = JSON.parse(data);
                if (p2UpdateData != []) {
                    editor.setData(p2UpdateData.content);
                    document.querySelector("#post-title").value = p2UpdateData.title;
                    document.querySelector("#post-type").value = p2UpdateData.content_type;
                    document.querySelector("#post-visibility").value = p2UpdateData.visibility;
                    document.querySelector("#post-category").value = p2UpdateData.category;

                } else if (p2UpdateData == []) {
                    /**
                     *  post to update not found
                     *  give option to create new post
                     */
                    editorDataBtn.textContent = "Can't Fetch Post Data...Create New Post Instead";
                    editorDataBtn.dataset.ot = "create";

                }
            })





        })
        updateBtn.textContent = "Update";
        footBtns.appendChild(updateBtn);
        //delete button
        let deletionBtn = document.createElement("button");
        deletionBtn.setAttribute("class", "btn btn-outline-light deletion-btn");
        deletionBtn.textContent = "Delete";
        deletionBtn.dataset.pid = object.id;

        deletionBtn.addEventListener("click", (e) => {
            /**
             *  code to delete post clicked
             */
            let response = prompt("Are you sure? Type in letter y to confirm");
            if (response == "y") {
                $.post("/post/editor/delete-post", {
                    "pid": e.target.dataset.pid
                }, (data, status) => {
                    //alert(data);
                    if (data == "1") {
                        e.target.parentNode.parentNode.parentNode.style.display = "none";
                    }
                })
            }
        })
        footBtns.appendChild(deletionBtn);
        // date
        let footDate = document.createElement("span");
        footDate.setAttribute("class", "date")
        footDate.textContent = object.date_updated;
        footer.appendChild(footDate)

    }

    /** 
     *  code for current user's posts search
     */
    let searchClearer = document.querySelector(".search-clearer");
    let selfPostSearch = document.querySelector("#sps");
    let spsResultCon = document.querySelector(".searched-posts");
    selfPostSearch.addEventListener("input", function(spsEvent) {
        // delete initial content
        spsResultCon.innerHTML = '';
        $.post("/post/editor/posts/search", {
            "terms": spsEvent.target.value
        }, function(data, status) {
            //alert(data)
            let sPosts = JSON.parse(data);
            if (sPosts.length > 0) {
                sPosts.forEach(sp => {
                    let spsPost = document.createElement("a");
                    spsPost.setAttribute("class", "suggestion");
                    spsPost.textContent = sp.title;
                    spsPost.dataset.spid = sp.id;
                    // to update post on click
                    spsPost.addEventListener("click", (suggestionEvent) => {
                        // for mobile screen
                        if (getDeviceWidth() < 992) {
                            $(".userposts2edit-con").fadeOut("fast");
                            $(".content-area").fadeIn("fast");

                        }
                        // processing
                        editorDataBtn.dataset.ot = "update";
                        editorDataBtn.dataset.postid = suggestionEvent.target.dataset.spid;
                        editorDataBtn.textContent = "Update This Post...";

                        $.post("/post/editor/post2edit", {
                            "post2edit": suggestionEvent.target.dataset.spid
                        }, function(data, status) {
                            //alert(data);
                            let postSugData = JSON.parse(data);
                            if (postSugData != []) {
                                editor.setData(postSugData.content);
                                document.querySelector("#post-title").value = postSugData.title;
                                document.querySelector("#post-type").value = postSugData.content_type;
                                document.querySelector("#post-visibility").value = postSugData.visibility;
                                document.querySelector("#post-category").value = postSugData.category;
                                // display alt delete button
                                let altDel = document.querySelector(".alt-del");
                                altDel.dataset.pid = suggestionEvent.target.dataset.spid;
                                altDel.style.display = "inline";

                            } else if (postSugData == []) {
                                /**
                                 *  post to update not found
                                 *  give option to create new post
                                 */
                                editorDataBtn.textContent = "Can't Fetch Post Data...Create New Post Instead";
                                editorDataBtn.dataset.ot = "create";

                            }
                        })

                    })
                    spsResultCon.appendChild(spsPost);
                });
            }
        });
    })

    // alternative post deletion btn
    let altDelBtn = document.querySelector(".alt-del");
    altDelBtn.addEventListener("click", (altE) => {
        let res = prompt("Are you sure? Type in letter y to confirm");
        if (res == "y") {
            $.post("/post/editor/delete-post", {
                "pid": altE.target.dataset.pid
            }, (data, status) => {
                //alert(data);
                if (data == "1") {
                    altE.target.textContent = "Deleted...";
                    setInterval(() => {
                        location.assign("/post/edit");
                    }, 1000);
                } else {
                    altE.target.textContent = "Something Went Wrong...";
                }
            })
        }
    });
}, 500);