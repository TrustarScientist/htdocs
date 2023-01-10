<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/base.css">
    <link rel="stylesheet" href="/static/css/learning.css">
    <script defer src="custom-js/jQuery.min.js"></script>
    <script defer src="custom-js/base.js"></script>
    <script defer src="custom-js/course-learning.js"></script>
    <title>Nav Design</title>
</head>

<body>
    <nav class="nav">
        <header class="head">
            <div class="brand">
                <img src="/images/eni.jpg" alt="comapany logo">
                <h1 class="name">Geneticks</h1>
            </div>
            <form action="/search/query" class="form">
                <input type="search" class="form-control" name="query" id="q" placeholder="search here...">
                <!--
                    <svg id="cancel" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-check2-all" viewBox="0 0 16 16">
                    <path d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z"/>
                    <path d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z"/>
                  </svg>
                -->
                <svg id="cancel" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                    <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
                  </svg>
            </form>
            <!--search display icon-->
            <div class="functions">
                <svg id="search" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                  </svg>
                <svg id="menu" xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-filter-left" viewBox="0 0 16 16">
                    <path d="M2 10.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"/>
                  </svg>
            </div>
        </header>
        <aside class="menu-options">
            <button class="btn ">Profile</button>
            <button class="btn ">Frames</button>
            <button class="btn ">UI Things</button>
            <button class="btn ">Notifications</button>
            <button class="btn ">Create Post</button>
            <button class="btn ">Settings</button>
        </aside>
        <footer class="foot">
            <h6><a href="/learn.html" class="text-light btn btn-primary">Learn</a></h6>
            <h6><a href="/socialize.html" class=" socialize btn btn-outline-primary">Socialize</a></h6>
            <h6><a href="practice.html" class="practice btn btn-outline-primary">Practice</a></h6>
        </footer>

    </nav>
    <div class="container-fluid">
        <section class="drow-a row">
            <div class="dcol col-lg-3">
                <section class="courseware">
                    <h5 class="course-title">Learn Django: Build 7 Job-ready Projects: Course Title</h5>
                    <div class="course-sections">
                        <section class="csection">
                            <header class="cs-head bg-primary">
                                <h6 class="cs-title">Intro to the World Wide Wide</h6>
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="white" class="bi bi-arrow-down-circle-fill" viewBox="0 0 16 16">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                                  </svg>
                            </header>
                            <div class="cs-content-con" style="transition: 1s;">
                                <article class="cs-mt bg-light">
                                    <span class="type">Assignment</span>
                                    <span class="desc">The description about the section material or assessment</span>

                                </article>
                                <article class="cs-mt bg-light">
                                    <span class="type">Video</span>
                                    <span class="desc">The description about the section material or assessment</span>
                                </article>
                                <article class="cs-mt bg-light">
                                    <span class="type">Blog Post</span>
                                    <span class="desc">The description about the section material or assessment</span>
                                </article>
                            </div>
                        </section>
                        <section class="csection">
                            <header class="cs-head bg-primary">
                                <h6 class="cs-title">Intro to CSS and Graphics Design with Corel Draw</h6>
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="white" class="bi bi-arrow-down-circle-fill" viewBox="0 0 16 16">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                                  </svg>
                            </header>
                            <div class="cs-content-con" style="transition: 1s;width: 0px;">
                                <article class="cs-mt bg-light">
                                    <span class="type">Test</span>
                                    <span class="desc">The description about the section material or assessment</span>
                                </article>

                            </div>
                        </section>
                        <section class="csection">
                            <header class="cs-head bg-primary">
                                <h6 class="cs-title">Computer Hardware</h6>
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="white" class="bi bi-arrow-down-circle-fill" viewBox="0 0 16 16">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                                  </svg>
                            </header>
                            <div class="cs-content-con" style="transition: 1s;">
                                <article data-type="test" data-uuid="h3@3u" class="cs-mt bg-light">
                                    <span class="type">Test</span>
                                    <span class="desc">The description about the section material or assessment</span>
                                </article>
                                <article class="cs-mt bg-light">
                                    <span class="type">Test</span>
                                    <span class="desc">The description about the section material or assessment</span>
                                </article>
                            </div>
                        </section>
                    </div>
                </section>
                <article class="claim-cert btn btn-danger" style="text-align: center;display: block;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                        <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                      </svg>
                    <p>CLAIM YOUR CERTIFICATE FOR THIS COURSE</p>
                </article>
            </div>
            <div class="dcol col-lg-6">

            </div>
            <div class="dcol col-lg-3"></div>
        </section>
    </div>
</body>

</html>