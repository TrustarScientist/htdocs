<!--
<?php
    // dataset to use is already imported throught the render function
    $error = "block";
    $shower = "none";
    $title = "";
    $banner  = "";
    $desc = "";
    $price = "";
    $updated = "";
    $course_id = "";
    if(!empty($dataset["course_details"])){
        $shower = "block";
        $error = "none";
        $title = ($dataset["course_details"])->title;
        $banner = ($dataset["course_details"])->banner;
        $desc = ($dataset["course_details"])->desc;
        $updated = ($dataset["course_details"])->date_updated;
        $price = ($dataset["course_details"])->price;
        $course_id = ($dataset["course_details"])->id;
    }
    $course_sections = array();
    if(!empty($dataset["course_sections"])){
        $course_sections = $dataset["course_sections"];
    }
 

?>
-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/base.css">
    <link rel="stylesheet" href="/static/css/course-details.css">
    <script defer src="/static/js/jQuery.min.js"></script>
    <script defer src="/static/bootstrap/js/bootstrap.min.js"></script>
    <script defer src="/static/js/course-details.js"></script>
    <title>Course Details Page</title>
</head>

<body>

    <nav class="navbar navbar-expand-sm bg-light  navbar-light fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="/static/images/about.jpg" alt="Avatar Logo" style="width:40px;" class="rounded-pill">
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
                <form class="d-flex" action="/search" method="POST">
                    <input class="form-control me-2" type="text" placeholder="Search">
                    <button class="btn btn-primary" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
    <main class="container-fluid pt-5">
        <section class="row pt-5" id="oc">
            <div class="col-lg-3">
                <section class="controller">
                    <div class="d-grid mb-3">
                        <button class="btn btn-primary btn-lg pb-2 other-courses" style="text-align: start;">Other Courses</button>
                    </div>
                    <div class="c-con">
                        <section class="courses">

                            <a href="rt" class="course btn btn-outline-primary">
                                <header class="head">
                                    <img class="banner" src="/static/images/download (2).jpg" alt="course banner">
                                    <h6 class="title">Backend Programming with Node.js, PHP and Python</h6>
                                </header>

                            </a>

                        </section>

                        <a href="/learn/courses" class="btn btn-outline-primary mb-3">More Available Courses</a>
                    </div>
                </section>
            </div>
            <div class="col-lg-6" ">
                <!-- php data injected... -->
                <section style="height: 400px; display: <?php echo $error; ?>">
                    <h1>No Such Course is Available</h1>
                </section>
                <div style="display:<?php echo $shower; ?>">
                <h1 class="course-title"><?php echo $title; ?></h1>
                <p class="updated">Updated: <span><?php echo $updated; ?></span></p>
                <img class="course-banner img-thumbnail" src="<?php echo $banner; ?>" alt="course banner">

                <h3 class="course-desc mt-3">
                    <?php echo $desc; ?>
                </h3>
                <div class="d-grid mt-3">
                    <div class="btn btn-primary" id="enrolment-btn" data-id="<?php echo $course_id; ?>">Enrol with <span><?php echo $price; ?></span> Naira</div>
                    <h4 class="error bg-danger text-light mt-3 p-2" style="display: none;">Something Went Wrong...</h4> 
                    <h4 class="login-needed bg-info text-light mt-3 p-2" style="display: none;">You need to log in to continue the enrolment process. click    <a href="/auth">here</a> to log in</h4>
                    <div class="payment-info-box btn">
                        <p>You have  <b class="balance">200</b> Naira in your wallet</p>
                        <a class="btn btn-secondary m-3 top-up-btn" href="#">Your wallet is low...top up your here...</a>
                        <button class="btn btn-danger confirmation-btn">Confirm Payment</button>
                    </div>
                </div>
                <hr>
                <h4 class="section-count">SECTIONS IN THIS COURSE...</h4>
                
                <hr>
                <section class="course-sections">
                    <?php foreach ($course_sections as  $course_section) {
                        # code...
                        $title = $course_section->title;
                        $description = $course_section->desc;
                        echo <<<SECTION
                                <div class="course-section bg-light p-2 mb-2">
                                <h5 class="title">$title</h5>
                                <p class="desc">$description</p>
                            </div>
                        SECTION;
                    } ?>
                </section>
                <div class="d-grid mb-1">
                    <p class="btn btn-primary">ENROL NOW!</p>
                </div>
                <a href="#oc" class="btn">View other courses...</a>
                <h4>Course Reviews so far...</h4>
                <section class="course-reviews">
                    <article class="course-review bg-light p-3 mt-3 mb-3">
                        <span class="review">The course just proved to me that I don't know anything yet...but recommends that I improve with practical experiences through projects</span>
                        <span>-</span>
                        <b>Adeyemi</b>
                    </article>
                </section>
                </div>
            </div>
        </section>
        <footer class="drow-last row bg-dark">
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
        </footer>
    </main>

</body>

</html>