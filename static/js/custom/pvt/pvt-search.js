setTimeout(() => {


    $(".result-scopes .posts-btn").css("border-bottom", "2px solid rgb(13, 139, 77)"); // default
    $(".result-scopes .people-btn").click(function(e) {
        $(".result-scopes .people-btn").css("border-bottom", "2px solid rgb(13, 139, 77)");
        $(".result-scopes .all-btn").css("border-bottom", "0");
        $(".result-scopes .posts-btn").css("border-bottom", "0");
        $(".result-scopes .niches-btn").css("border-bottom", "0");
        //

        $(".all-results-section").css("display", "none")
        $(".posts-results-section").css("display", "none")
        $(".niches-results-section").css("display", "none")
        $(".people-results-section").fadeIn("fast");
    });

    $(".result-scopes .posts-btn").click(function(e) {
        $(".result-scopes .posts-btn").css("border-bottom", "2px solid rgb(13, 139, 77)");
        $(".result-scopes .people-btn").css("border-bottom", "0");
        $(".result-scopes .all-btn").css("border-bottom", "0");
        $(".result-scopes .niches-btn").css("border-bottom", "0");
        //

        $(".people-results-section").css("display", "none")
        $(".all-results-section").css("display", "none")
        $(".niches-results-section").css("display", "none")
        $(".posts-results-section").fadeIn("fast");
    });

    $(".result-scopes .niches-btn").click(function(e) {
        $(".result-scopes .niches-btn").css("border-bottom", "2px solid rgb(13, 139, 77)");
        $(".result-scopes .people-btn").css("border-bottom", "0");
        $(".result-scopes .posts-btn").css("border-bottom", "0");
        $(".result-scopes .all-btn").css("border-bottom", "0");
        //

        $(".people-results-section").css("display", "none")
        $(".posts-results-section").css("display", "none")
        $(".all-results-section").css("display", "none")
        $(".niches-results-section").fadeIn("fast");
    });

    /** code for result types */
    // let extract = /[\/\w:\d\.]+[\?]query=([\w+:?#%\d]*)/.exec(window.location.href)
    // extract = extract[1].replace("+", " ");
    // alert(extract);
    let url = new URL(window.location.href);
    let query = url.searchParams.get("query");
    let contentType = url.searchParams.get("ct");
    if (contentType == null) {
        document.querySelector(".ts-results-container").style.display = "block";
        document.querySelector(".the-query").textContent = query;
        //
        let peopleSearchedCon = document.querySelector(".people-results-section .people");
        let peopleSearchedBtn = document.querySelector(".more-searched-people");
        //
        let searchedPostsCon = document.querySelector(".posts-results-section .userposts");
        let searchedPostsBtn = document.querySelector(".more-searched-posts");
        //
        let searchedNichesCon = document.querySelector(".niches-results-section .niches");
        let searchedNichesBtn = document.querySelector(".more-searched-niches");
        /**
         *  site wide search code
         */
        // person search...
        $.post("/search", {
            "type": "person",
            "query": query,
            "starting": 0,
            "amount": 5
        }, (data, status) => {
            //alert(data);
            let searchedPeopleResult = JSON.parse(data);
            if (searchedPeopleResult.length > 0) {
                searchedPeopleResult.forEach(spr => {
                    personBuilder(spr, peopleSearchedCon);
                });
                peopleSearchedBtn.dataset.pos = searchedPeopleResult.length;
                peopleSearchedBtn.style.display = "inline";
            } else {
                peopleSearchedCon.innerHTML = `<h4 class="p-1">No results for people...</h4>`;
            }
        });
        // more people
        peopleSearchedBtn.addEventListener("click", (psbEvent) => {
            $.post("/search", {
                "type": "person",
                "query": query,
                "starting": psbEvent.target.dataset.pos,
                "amount": 5,

            }, (data, status) => {
                let searchedPeopleResult2 = JSON.parse(data);
                if (searchedPeopleResult2.length > 0) {
                    searchedPeopleResult2.forEach(s2 => {
                        personBuilder(s2, peopleSearchedCon);
                    });
                    peopleSearchedBtn.dataset.pos = Number(peopleSearchedBtn.dataset.pos) + searchedPeopleResult2.length;

                } else {
                    peopleSearchedBtn.style.display = "none";
                }
            });
        })


        // post search
        $.post("/search", {
            "type": "post",
            "query": query,
            "starting": 0,
            "amount": 5
        }, (data, status) => {
            //alert(data);
            let searchedPostsResult = JSON.parse(data);
            if (searchedPostsResult.length > 0) {
                searchedPostsResult.forEach(spPost => {
                    postBuilder(spPost, searchedPostsCon);
                });
                searchedPostsBtn.dataset.pos = searchedPostsResult.length;
                searchedPostsBtn.style.display = "inline";
            } else {
                searchedPostsCon.innerHTML = `<h4 class="p-1">No results for posts...</h4>`;
            }
        });
        //more posts
        searchedPostsBtn.addEventListener("click", (posbEvent) => {
            $.post("/search", {
                "type": "post",
                "query": query,
                "starting": posbEvent.target.dataset.pos,
                "amount": 5,

            }, (data, status) => {
                //alert(data);
                let searchedPostsResult2 = JSON.parse(data);
                if (searchedPostsResult2.length > 0) {
                    searchedPostsResult2.forEach(spos2 => {
                        postBuilder(spos2, searchedPostsCon);
                    });
                    searchedPostsBtn.dataset.pos = Number(searchedPostsBtn.dataset.pos) + searchedPostsResult2.length;

                } else {
                    searchedPostsBtn.style.display = "none";
                }
            });
        });


        // niche search
        $.post("/search", {
            "type": "niche",
            "query": query,
            "starting": 0,
            "amount": 5
        }, (data, status) => {
            //alert(data);
            let searchedNichesResult = JSON.parse(data);
            if (searchedNichesResult.length > 0) {
                searchedNichesResult.forEach(snNiche => {
                    nicheMaker2(snNiche, searchedNichesCon);
                });
                searchedNichesBtn.dataset.pos = searchedNichesResult.length;
                searchedNichesBtn.style.display = "inline";
            } else {
                searchedNichesCon.innerHTML = `<h4 class="p-1">No results for niches...</h4>`;
            }
        });
        // more niches
        searchedNichesBtn.addEventListener("click", (snbEvent) => {
            $.post("/search", {
                "type": "niche",
                "query": query,
                "starting": snbEvent.target.dataset.pos,
                "amount": 5,

            }, (data, status) => {
                //alert(data);
                let searchedNichesResult2 = JSON.parse(data);
                if (searchedNichesResult2.length > 0) {
                    searchedNichesResult2.forEach(snN2 => {
                        nicheMaker2(snN2, searchedNichesCon);
                    });
                    searchedNichesBtn.dataset.pos = Number(searchedNichesBtn.dataset.pos) + searchedNichesResult2.length;

                } else {
                    searchedNichesBtn.style.display = "none";
                }
            });
        });


    } else {
        document.querySelector(".ts-results-container").style.display = "none";
        document.querySelector(".cs-results-container").style.display = "block";
        $.post("/ct_search", {
            "ct": contentType,
            "starting": 0,
            "amount": 2

        }, (data, status) => {
            alert(data)
        });
    }









    document.querySelector(".sitewide-loader").style.display = "none";

}, 500);