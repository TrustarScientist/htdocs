<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/base.css">
    <script defer src="static/js/jQuery.min.js"></script>
    <script defer src="static/bootstrap/js/bootstrap.min.js"></script>
    <script defer src="static/js/base.js"></script>
    <title>Search Result Page</title>
</head>

<body>

    <nav class="navbar navbar-expand-sm bg-light  navbar-light fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">
                <img src="static/images/about.jpg" alt="Avatar Logo" style="width:40px;" class="rounded-pill">
                <b class="ge">GENETICKS</b>
                <b class="co">COMPUTER</b>
                <b class="in">INSTITUTE</b>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
          </button>
            <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/auth">Login</a>
                    </li>
                    <li class="nav-item dropdown mb-3">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">More Options</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/learn/courses">Courses</a></li>
                            <li><a class="dropdown-item" href="/practice/labs">Labs</a></li>
                            <li><a class="dropdown-item" href="/socialize/posts">Posts</a></li>
                            <li><a class="dropdown-item" href="/news">News From Geneticks</a></li>
                            <li><a class="dropdown-item" href="/about">About Us</a></li>
                            <li><a class="dropdown-item" href="/contact">Contact Us</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex" action="/search/" method="POST">
                    <input class="form-control me-2" type="text" placeholder="Search">
                    <button class="btn btn-primary" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
    <main class="container-fluid">

        <section class="row">
            <div class="dcol-first col-lg-12">
                <div class="welcome-con">
                    <header class="welcome-note">
                        <h1 class="intro">Welcome to the Universe of Learning and Problem-Solving</h1>
                        <section class="desc">
                            Here we learn new, beautiful things...together; profer solutions to our daring challenges...together; become highly knowledgeable humans...again...together.
                        </section>

                    </header>
                    <img src="static/images/orsrc68810.jpg" class="site-intro">
                    <div class="core-links">
                        <a class="btn btn-primary" href="/learn/courses">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                </svg>
                        </a>
                        <a class="btn btn-secondary" href="/socialize/posts">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
                            <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
                            <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                            </svg>
                        </a>
                        <a class="btn btn-danger" href="/practice/labs">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                            <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <section class="row">
            <h2 class="why" style="text-align: center;">WHY LEARN AT GENETICKS?</h2>
        </section>
        <section class="row">

        </section>
        <section class="drow-stats row bg-dark">
            <div class="col-md-6 col-lg-3">
                <article class="statistics  btn btn-light">
                    <h1 class="count text-danger"><span>500,000</span>+</h1>
                    <span class="desc">Meaninful contents shared and read so far. They include possible solutions to your challenges.</span>
                </article>

            </div>
            <div class="col-md-6 col-lg-3">
                <article class="statistics btn btn-light">
                    <h1 class="count text-danger"><span>25,000</span>+</h1>
                    <span class="desc">Individuals and professionals have accounts with us and enjoy all of Geneticks</span>
                </article>
            </div>
            <div class="col-md-6 col-lg-3">
                <article class="statistics btn btn-light">
                    <h1 class="count text-danger"><span>3</span>+</h1>
                    <span class="desc">Hybrid (Online and Offline) courses to suite your learning styles</span>
                </article>
            </div>
            <div class="col-md-6 col-lg-3">
                <article class="statistics btn btn-light">
                    <h1 class="count text-danger"><span>1</span>+</h1>
                    <span class="desc">Virtual Labs to test your knowledge. More on the way...</span>
                </article>
            </div>
        </section>
        <section class="row">
            <h3 class="formular bg-light" style="text-align: center;">OUR FORMULAR: HIGH QUALITY RESOURCES + EXPRESSION OF THOUGHTS + PRACTICAL EXPERIENCE = ADVANCEMENT</h3>
        </section>
        <section class="row">

        </section>
        <section class="drow-middle row">
            <div class="col-lg-3">
                <hr>
                <section class="courses">
                    <!-- 
                                  <a href="rt" class="course btn btn-outline-primary">
                        <header class="head">
                            <img class="banner" src="static/images/download (2).jpg" alt="course banner">
                            <h6 class="title">Backend Programming with Node.js, PHP and Python</h6>
                        </header>

                    </a>
                   
-->
                </section>

                <a href="/learn/courses" class="btn btn-outline-primary mb-3">More Available Courses</a>
            </div>
            <div class=" col-lg-6">
            <section class="userposts">
                    <article class="userpost btn btn-outline-light">
                        <h6 class="post-title"><a href="/post-details.html">Why Would Anyone Ever Vote for Tinubu and Atiku...without Studying History really Well?</a></h6>

                        <footer class="post-foot">
                            <section class="ID">
                                <img src="/static/images/banner-right-image.png" alt="user photo">
                                <a href="rrr" class="uand">
                                    <b class="name">TrustarScientist</b>
                                    <span class="date">2 days ago</span>
                                </a>
                            </section>
                            <section class="stats">
                                <div class="upvote">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-circle" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
                                      </svg>
                                    <p class="uv">1004</p>
                                </div>
                                <div class="comment">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
                                        <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
                                        <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                        </svg>
                                    <p class="ct">3568</p>
                                </div>
                                <div class="downvote">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                                        <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                                      </svg>
                                    <p class="dv">1298</p>
                                </div>
                            </section>
                        </footer>
                    </article>
                    <article class="userpost btn btn-outline-light">
                        <h6 class="post-title"><a href="/post-details.html">Python Django vs Node.js Express.js: Which One to Choose for Ecommerce App?</a></h6>
                        <div class="tags-container">
                        </div>
                        <footer class="post-foot">
                            <section class="ID">
                                <img src="/static/images/banner-right-image.png" alt="user photo">
                                <a href="rrr" class="uand">
                                    <b class="name">pHYCHEMMA</b>
                                    <span class="date">2 days ago</span>
                                </a>
                            </section>
                            <section class="stats">
                                <div class="upvote">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-circle" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
                                      </svg>
                                    <p class="uv">1004</p>
                                </div>
                                <div class="comment">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
                                        <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
                                        <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                        </svg>
                                    <p class="ct">3568</p>
                                </div>
                                <div class="downvote">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                                        <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                                      </svg>
                                    <p class="dv">1298</p>
                                </div>
                            </section>
                        </footer>
                    </article>
                    <article class="userpost btn btn-outline-light">
                        <h6 class="post-title"><a href="/post-details.html">Why Would Anyone Ever Vote for Tinubu and Atiku...without Studying History really Well?</a></h6>

                        <footer class="post-foot">
                            <section class="ID">
                                <img src="/static/images/banner-right-image.png" alt="user photo">
                                <a href="rrr" class="uand">
                                    <b class="name">TrustarScientist</b>
                                    <span class="date">2 days ago</span>
                                </a>
                            </section>
                            <section class="stats">
                                <div class="upvote">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-circle" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
                                      </svg>
                                    <p class="uv">1004</p>
                                </div>
                                <div class="comment">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
                                        <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
                                        <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                        </svg>
                                    <p class="ct">3568</p>
                                </div>
                                <div class="downvote">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eyeglasses" viewBox="0 0 16 16">
                                        <path d="M4 6a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm2.625.547a3 3 0 0 0-5.584.953H.5a.5.5 0 0 0 0 1h.541A3 3 0 0 0 7 8a1 1 0 0 1 2 0 3 3 0 0 0 5.959.5h.541a.5.5 0 0 0 0-1h-.541a3 3 0 0 0-5.584-.953A1.993 1.993 0 0 0 8 6c-.532 0-1.016.208-1.375.547zM14 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                                      </svg>
                                    <p class="dv">1298</p>
                                </div>
                            </section>
                        </footer>
                    </article>

                </section>
                <a href="/socialize/posts" class="router btn btn-outline-secondary mb-3">See More discussions</a>
            </div>
            </div>
            <div class="col-lg-3">
                <hr>
                <section class="vlabs">
                    
                    <article class="vlab btn-outline-danger" data-url="userposts.html" data-active="0">
                        <img class="image" src="static/images/download.jpg" alt="vlab">
                        <p class="name">WEB EDITOR</p>
                    </article>
                    <article class="vlab btn-outline-danger" data-url="marketplace.html" data-active="0">
                        <img class="image" src="static/images/eni.jpg" alt="vlab">
                        <p class="name">JAMB PREP</p>
                    </article>
                </section>
                <a href="/practice/labs" class="router btn btn-outline-danger mt-3">View Virtual Labs</a>
            </div>
        </section>
        <section class="row">
            <h3 class="bg-secondary text-light pt-3 pb-3" style="text-align: center;">WHAT PEOPLE ARE SAYING ABOUT THE GENETICKS PLATFORM</h3>
        </section>
        <section class="drow-testimonials row">

            <div class="col-md-6 col-lg-3">
                <article class="testimonial btn btn-light">
                    <img src="static/images/cpt_engineer.jpg" alt="">
                    <p>
                        <span>One thing I like about the Geneticks Platform is that: it gets the education processes really right. Kudos to the Team. We need more of you though.</span>
                        <b class="name text-danger">Alexandra Ojo</b>
                    </p>
                </article>
            </div>
            <div class="col-md-6 col-lg-3">
                <article class="testimonial btn btn-light">
                    <img src="static/images/eni.jpg" alt="">
                    <p>
                        <span>Geneticks is so much fun and a'skill accelerator'...</span>
                        <b class="name text-danger">Tim Cook</b>
                    </p>
                </article>
            </div>
            <div class="col-md-6 col-lg-3">
                <article class="testimonial btn btn-light">
                    <img src="static/images/download (3).jpg" alt="">
                    <p>
                        <span>Geneticks is so much fun and a'skill accelerator'...</span>
                        <b class="name text-danger">Adewale Zebra</b>
                    </p>
                </article>
            </div>
            <div class="col-md-6 col-lg-3">
                <article class="testimonial btn btn-light">
                    <img src="static/images/person_2-removebg-preview.png" alt="">
                    <p>
                        <span>Geneticks is so much fun and a'skill accelerator'...</span>
                        <b class="name text-danger">Xi Jingpi</b>
                    </p>
                </article>
            </div>
            <hr>
        </section>
        <section class="drow-last row bg-dark">
            <div class="d-lastcol col-lg-4">
                <section class="site-main-links">
                    <a class="btn btn-outline-light" href="#">Register</a>
                    <a class="btn btn-outline-light" href="#">Login</a>
                    <a class="btn btn-outline-light" href="#">Courses</a>
                    <a class="btn btn-outline-light" href="#">Posts</a>
                    <a class="btn btn-outline-light" href="#">Labs</a>
                </section>
            </div>
            <div class="dcol-last col-lg-4">
                <section class="company-main-links">
                    <a class="btn btn-outline-light" href="#">About Us</a>
                    <a class="btn btn-outline-light" href="#">News</a>
                    <a class="btn btn-outline-light" href="#">User Data & Privacy</a>
                    <a class="btn btn-outline-light" href="#">Terms & Legality</a>
                </section>
            </div>
            <div class="dcol-last col-lg-4">
                <section class="contact-main-links">
                    <a href="#" class="btn btn-outline-light">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
                            <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"/>
                          </svg>
                        <span>Facebook</span>
                    </a>
                    <a href="#" class="btn btn-outline-light">

                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16">
                            <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/>
                        </svg>
                        <span>Twitter</span>
                    </a>

                    <a href="#" class="btn btn-outline-light">

                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16">
                            <path d="M13.601 2.326A7.854 7.854 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.933 7.933 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.898 7.898 0 0 0 13.6 2.326zM7.994 14.521a6.573 6.573 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.557 6.557 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592zm3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.729.729 0 0 0-.529.247c-.182.198-.691.677-.691 1.654 0 .977.71 1.916.81 2.049.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232z"/>
                        </svg>
                        <span href="#">Whatsapp</span>
                    </a>
                </section>
            </div>
            <div class="dcol-last col-lg-12">
                <section class="company-info btn btn-outline-light" style="display: block;">
                    <h3>&copy; <span>Geneticks Computer Institute</span></h3>
                    <h6>All Rights Reserved</h6>
                    <div>2009-present</div>
                    <p class="addr">61 Opposite West Hall College, Along Ajegunle-Itaoluwo Road, Itaoluwo, Ikorodu, Lagos State, Nigeria</p>
                    <p class="legal">(BN178335)</p>
                </section>
            </div>
        </section>
    </main>
</body>

</html>