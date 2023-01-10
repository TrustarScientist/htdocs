-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2023 at 10:01 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ssd`
--

-- --------------------------------------------------------

--
-- Table structure for table `acct`
--

CREATE TABLE `acct` (
  `id` int(11) NOT NULL,
  `username` varchar(25) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `pswd` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `nationality` varchar(28) DEFAULT NULL,
  `state_of_origin` varchar(28) DEFAULT NULL,
  `lga` varchar(28) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `intro` varchar(500) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `photo` varchar(128) DEFAULT NULL,
  `marital_status` char(1) DEFAULT NULL,
  `date_registered` date DEFAULT NULL,
  `last_login` date DEFAULT NULL,
  `wallet_amt` int(11) DEFAULT 0,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `acct`
--

INSERT INTO `acct` (`id`, `username`, `email`, `pswd`, `phone_number`, `gender`, `nationality`, `state_of_origin`, `lga`, `address`, `dob`, `intro`, `occupation`, `photo`, `marital_status`, `date_registered`, `last_login`, `wallet_amt`, `first_name`, `last_name`) VALUES
(2, 'TrustarScientist', 'dtrustarscientist@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$cE5uYmNFcmVnV3ZieTdMMQ$ualknVyQmZCsSAcfnbjeo8zhvFRhFYc/HQdJTHLxGhs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6920000, NULL, NULL),
(3, 'Ope', 'ope@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$UlNVQ3dtQWZKcFJoU3U0dg$qlTYi4cJ25MztfmTCGtPhhqiF8J00AvcWwWreu8kbtU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(4, 'Moj', 'mojisola@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$SHFTTHg1SXNGZVQ2T3g1ZA$dODfG/3MNzDNP6vApbIdKqN6tn46FWsxnVvUhAKM2wM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(5, 'Phychemma', 'phychemma@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$dFZ6T0E4aldvejVPUC50UQ$Ebsdedsm1luQyVIDaHVKC0R/LZwuV/nBd/ti5hxRdA0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(6, 'Alimat', 'alimat@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$WDc1aFRwYXZIUVFGTTRZMw$n/fhQ0HXOZa9FrKRcqfor62enfIEIUxLThd3ysHqU8s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(7, 'Instructor1', 'instructor1@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$TmNKVlVocHhXVmtNcUVHag$kGZ4q+MH46o6PFn8zqsJLbYgsd/B0ow2sk8vKKUOwUI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(8, 'admin1', 'admin1@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$TEw2U1hQa05rNy5WMU1EZw$9mmU3L8AwBWbNH4n1C0cZd5JSLY9/v4W9scwgSrfG7s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(9, '', '', '$argon2id$v=19$m=65536,t=4,p=1$b2JlbDIzbW9UYXpNWXZPbA$kgN1r/lYXuxZcz0CNzSxfQhrzO3KOK4i+k+/KrgmBiE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(10, 'trustar', 'trustar@gmail.com', '$2y$10$.jfjiAYj40iYAe4JVSROOuOQITVb8ieNXz78akmXkBk0UlqqH/mZm', '87867564534', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL),
(12, 'trustar2', 'trustar@gmail.com', '$2y$10$5WptBiKCgUkIj8iPr.xDKuXg3jyojQ4Oq31GGdbR8pbMA9WHLwSq6', '87867564534', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL),
(13, 'trustar3', 'trustar@gmail.com', '$2y$10$/y7yAOz7K3JF7GX9Cfmm6.DvRELAWHP7lwB8L1hxuHn0pksvBOPBW', '87867564534', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL),
(14, 'trustar4', 'trustar@gmail.com', '$2y$10$6GzhHdDNkRYwoImOcQMgzei3jcepia2Wej4RZbO6t7raFZpBAnY5.', '87867564534', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL),
(15, 'trustar5', 'trustar@gmail.com', '$2y$10$YgdQdjcTgW52/BzPQz.5tOMmVfNQ1WKHxwiB0RzXwc3XZp0OW6XnW', '87867564534', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL),
(16, 'TrustarSc', 'we@gmail.com', '$2y$10$VDFrptFvTAyb.F7tPXdoiuzKaGyPErwJF5vBuIFC/e9xfkml9oF3S', '1457473538', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL),
(17, 'd', 'd@gmail.com', '$2y$10$ihomgoCvbjsks.aY/tprd.jgIKq9gF617Yhjs5IxjHkvZXs0eP2ru', '4436644667', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-04', NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `acct_transaction`
--

CREATE TABLE `acct_transaction` (
  `id` int(11) NOT NULL,
  `acct` int(11) NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `type` varchar(7) DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL,
  `evidence_path` varchar(128) DEFAULT NULL,
  `desc` varchar(128) DEFAULT NULL,
  `amt` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` tinyint(4) NOT NULL,
  `auth_id` int(11) NOT NULL,
  `id_token` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` smallint(6) NOT NULL,
  `date_created` date DEFAULT NULL,
  `date_updated` date DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `banner` varchar(128) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `ending_date` date DEFAULT NULL,
  `prerequisite` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `date_created`, `date_updated`, `title`, `slug`, `banner`, `desc`, `price`, `starting_date`, `ending_date`, `prerequisite`) VALUES
(1, '2022-12-13', '2022-12-07', 'CS8', 'CS8', '/static/images/eni.jpg', 'This is the most basic course for anyone whose computer knowledge is a  bit rusty. The course is actually Computer Science 0.0 : to reflect the fact that it give you the minimum teachings for your advancement', 10000, '2023-01-09', '2023-03-31', NULL),
(2, '2023-01-02', '2023-01-10', 'Frontend Web Development', 'frontend-web-development', '/static/images/about.jpg', 'This course is part of the Full Stack Web Develoment course. It particularly focuses on the User Interface Design of websites: Their looks and feels.', 100000, '2023-01-09', '2023-04-10', NULL),
(3, '2023-01-01', '2023-01-10', 'Full Stack Web Development', 'fullstack-web-development', '/static/images/about.jpg', 'This course is the flagship course at Geneticks. It focuses exclusively on the website type of programming', 200000, '2023-01-15', '2023-04-25', NULL),
(4, '2023-01-01', '2023-01-08', 'Backend Web Development', 'backend-web-development', '/static/images/enibug.jpg', 'The couese is the half of the full stack web development. It focues on the behide-the-scenes, \"brain\" aspect of most Web, Desktop or Mobile Applications. You will learn PHP, NODE.JS and PYTHON Django.', 150000, '2023-01-29', '2023-03-31', NULL),
(5, '2023-01-03', '2023-01-18', 'Data Analysis', 'data-analysis', '/static/images/about.jpg', 'This is the first step into  Data Science, Data Mining, Machine Learning etc.', 350000, '2023-01-16', '2023-06-28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `course_assignment`
--

CREATE TABLE `course_assignment` (
  `id` int(11) NOT NULL,
  `course_section` mediumint(9) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_assignment_response`
--

CREATE TABLE `course_assignment_response` (
  `id` int(11) NOT NULL,
  `assignment` int(11) NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `score` smallint(6) DEFAULT 0,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_discuss`
--

CREATE TABLE `course_discuss` (
  `id` int(11) NOT NULL,
  `course` smallint(6) NOT NULL,
  `course_section` mediumint(9) DEFAULT NULL,
  `sender` int(11) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_discuss_reply`
--

CREATE TABLE `course_discuss_reply` (
  `id` int(11) NOT NULL,
  `course_discuss` int(11) NOT NULL,
  `replyer` int(11) NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `body` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_enrolment`
--

CREATE TABLE `course_enrolment` (
  `id` int(11) NOT NULL,
  `course` smallint(6) NOT NULL,
  `acct` int(11) NOT NULL,
  `date_enrolled` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course_enrolment`
--

INSERT INTO `course_enrolment` (`id`, `course`, `acct`, `date_enrolled`) VALUES
(23, 1, 2, '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `course_instructor`
--

CREATE TABLE `course_instructor` (
  `id` smallint(6) NOT NULL,
  `course` smallint(6) NOT NULL,
  `instructor` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_quiz`
--

CREATE TABLE `course_quiz` (
  `id` int(11) NOT NULL,
  `course` smallint(6) NOT NULL,
  `course_section` mediumint(9) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `opt1` varchar(288) DEFAULT NULL,
  `opt2` varchar(288) DEFAULT NULL,
  `opt3` varchar(288) DEFAULT NULL,
  `opt4` varchar(288) DEFAULT NULL,
  `correct_answer` varchar(288) DEFAULT NULL,
  `course_section_mime_uuid` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_review`
--

CREATE TABLE `course_review` (
  `id` smallint(6) NOT NULL,
  `course` smallint(6) NOT NULL,
  `reviewer` int(11) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_section`
--

CREATE TABLE `course_section` (
  `id` mediumint(9) NOT NULL,
  `course` smallint(6) NOT NULL,
  `position` tinyint(4) DEFAULT 0,
  `desc` varchar(500) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course_section`
--

INSERT INTO `course_section` (`id`, `course`, `position`, `desc`, `title`) VALUES
(1, 1, 1, 'We are all familiar with the word \'technology\' but do you know it exists in the first place? The section talks about that.', 'PROBLEM-SOLVING: THE BIRTH OF TECHNOLOGY'),
(2, 1, 2, 'Now that we know the big picture around technology, let\'s get specific. In this section, we will dive deep into the world of Information Technology.', 'Information Technology '),
(3, 1, 3, 'Computers are really clever machines that have undergone, and yet geometrically undergoing, improvement over the last 50 years. It\'s important we learn their body parts to really understand how they work.', 'THE MACHINE CALLED COMPUTER'),
(4, 1, 4, 'The computer hardware turns out to be  a complicated piece of reality. In the section we will learn how software were made to exist and why the are do ambitious.', 'SOFTWARE TO THE RESCUE'),
(5, 1, 5, 'Well...so far I have been hiding so much from you. Don\'t blame me: I just told you that the world of computers is really complicated. So let\'s see to that now. And we will have Q&A sessions also. Finally, we will learn how the apps you use everyday are made.', 'HOW APPS ARE MADE & THEIR NOTORIOUS DETAILS'),
(6, 1, 6, 'Computers these days don\'t live in isolation...just like you probably. Gossiping is not always bad. Even the internet is based on this fact. So, let\'s dig out some of the many behind the scenes principles, events and infrastructure that make communications possible.', 'COMPUTER NETWORKING'),
(7, 1, 7, 'Yeah we are at the final phase of this course. Of what essence is knowledge that is not useful in the practical world really? In the section, we will do some adventurous projects. You don\'t have to know...but put your brains to work like computers: think deep, wide and, to some extent, wild.', 'USING THE COMPUTER TO SOLVE PROBLEMS');

-- --------------------------------------------------------

--
-- Table structure for table `course_section_audio`
--

CREATE TABLE `course_section_audio` (
  `id` int(11) NOT NULL,
  `course_section` mediumint(9) DEFAULT NULL,
  `position` tinyint(4) DEFAULT 0,
  `desc` varchar(500) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `uuid` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_section_doc`
--

CREATE TABLE `course_section_doc` (
  `id` int(11) NOT NULL,
  `course_section` mediumint(9) DEFAULT NULL,
  `position` tinyint(4) DEFAULT 0,
  `desc` varchar(500) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `uuid` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course_section_video`
--

CREATE TABLE `course_section_video` (
  `id` int(11) NOT NULL,
  `course_section` mediumint(9) DEFAULT NULL,
  `position` tinyint(4) DEFAULT 0,
  `desc` varchar(500) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `uuid` varchar(128) DEFAULT NULL,
  `course` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `general_photo`
--

CREATE TABLE `general_photo` (
  `id` int(11) NOT NULL,
  `path` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `id` smallint(6) NOT NULL,
  `auth_id` int(11) NOT NULL,
  `resume_path` varchar(128) DEFAULT NULL,
  `date_verified` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `instructor_assignment_response_remark`
--

CREATE TABLE `instructor_assignment_response_remark` (
  `id` int(11) NOT NULL,
  `assignment_response` int(11) NOT NULL,
  `instructor` smallint(6) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `post_tag`
--

CREATE TABLE `post_tag` (
  `id` int(11) NOT NULL,
  `tag` int(11) NOT NULL,
  `post` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` mediumint(9) NOT NULL,
  `auth_id` int(11) NOT NULL,
  `has_nok` tinyint(4) DEFAULT 0,
  `nok_fullname` varchar(255) DEFAULT NULL,
  `nok_occupation` varchar(128) DEFAULT NULL,
  `nok_phone_number` varchar(15) DEFAULT NULL,
  `nok_bizplace_info` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student_result`
--

CREATE TABLE `student_result` (
  `id` int(11) NOT NULL,
  `acct` int(11) DEFAULT NULL,
  `course` smallint(6) DEFAULT NULL,
  `cert` varchar(128) DEFAULT NULL,
  `date_issued` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `userpost`
--

CREATE TABLE `userpost` (
  `id` int(11) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `date_updated` date DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `upvote_count` int(11) DEFAULT NULL,
  `downvote_count` int(11) DEFAULT NULL,
  `poster` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userpost`
--

INSERT INTO `userpost` (`id`, `title`, `date_created`, `date_updated`, `slug`, `content`, `upvote_count`, `downvote_count`, `poster`) VALUES
(1, 'What  is the essence of node.js when PHP & Python are really great?', '2023-01-02', '2023-01-18', 'What-is-the-essence-of-node.js-when-PHP-&-Python-are-really-great?', 'Node.js just came out of nowhere. Then big companies bought the idea even to point of recoding their existing infrastructure. What\'s the cruise?', 3, 0, 2),
(2, 'What\'s all about the crypto craze?', '2023-01-09', '2023-01-20', 'What\'s all about the crypto craze?', 'I\'ve heard of Bitcoin, Ethereum, dogecoin , among others. But what\'s the advantage here?', 363, 8, 5),
(3, 'post 3 titlte', '2023-01-01', '2023-01-17', NULL, 'post 3 content', 2, 1, 3),
(4, 'post', '2023-01-08', '2023-01-12', NULL, 'post4', 733, 20, 12),
(5, 'post5', '2023-01-09', '2023-01-24', 'post-5', 'post-5 content', 0, 0, 6),
(6, 'post 6', '2023-01-17', '2023-01-19', 'post-6', 'post 6 content', 363, 2, 14),
(7, 'my 7th post title', '2023-01-02', '2023-01-19', 'my 7th post title', 'my 7th post description ', 25, 2, 16),
(8, 'Why i think TrustrScientist is awesome ', '2023-01-10', '2023-01-24', 'Why-I-think-TrustrScientist-is-awesome', 'His personality is just rare and beautiful doh...', 10030, 456, 2);

-- --------------------------------------------------------

--
-- Table structure for table `userpost_comment`
--

CREATE TABLE `userpost_comment` (
  `id` mediumint(9) NOT NULL,
  `post` int(11) NOT NULL,
  `commenter` int(11) DEFAULT NULL,
  `body` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `userpost_comment_reply`
--

CREATE TABLE `userpost_comment_reply` (
  `id` smallint(6) NOT NULL,
  `replyer_id` int(11) NOT NULL,
  `comment_id` mediumint(9) NOT NULL,
  `body` varchar(500) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vlab`
--

CREATE TABLE `vlab` (
  `id` int(11) NOT NULL,
  `banner` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vlab`
--

INSERT INTO `vlab` (`id`, `banner`, `name`, `path`) VALUES
(1, 'static/images/enibug.jpg', 'WAEC ASSIST', '/practie/lab/waec-assist'),
(2, 'static/images/enibug.jpg', 'JAMB PREP', '/practie/lab/waec-assist');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acct`
--
ALTER TABLE `acct`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `acct_transaction`
--
ALTER TABLE `acct_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acct_in_transaction` (`acct`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_auth_id` (`auth_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_assignment`
--
ALTER TABLE `course_assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `csec_id` (`course_section`);

--
-- Indexes for table `course_assignment_response`
--
ALTER TABLE `course_assignment_response`
  ADD PRIMARY KEY (`id`),
  ADD KEY `csec_ass_id` (`assignment`);

--
-- Indexes for table `course_discuss`
--
ALTER TABLE `course_discuss`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_discussed` (`course`),
  ADD KEY `course_section_discussed` (`course_section`),
  ADD KEY `discussion_sender_id` (`sender`);

--
-- Indexes for table `course_discuss_reply`
--
ALTER TABLE `course_discuss_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_discuss_id` (`course_discuss`),
  ADD KEY `discussion_replyer_id` (`replyer`);

--
-- Indexes for table `course_enrolment`
--
ALTER TABLE `course_enrolment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_enrolled_in` (`course`),
  ADD KEY `acct_enrolling` (`acct`);

--
-- Indexes for table `course_instructor`
--
ALTER TABLE `course_instructor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_instructing` (`course`),
  ADD KEY `course_instructor_id` (`instructor`);

--
-- Indexes for table `course_quiz`
--
ALTER TABLE `course_quiz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `c_for_quiz` (`course`),
  ADD KEY `csection_id` (`course_section`);

--
-- Indexes for table `course_review`
--
ALTER TABLE `course_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_reviewed` (`course`),
  ADD KEY `course_reviewer_id` (`reviewer`);

--
-- Indexes for table `course_section`
--
ALTER TABLE `course_section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_sectioned` (`course`);

--
-- Indexes for table `course_section_audio`
--
ALTER TABLE `course_section_audio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cs_id_for_audio` (`course_section`);

--
-- Indexes for table `course_section_doc`
--
ALTER TABLE `course_section_doc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cs_id_for_doc` (`course_section`);

--
-- Indexes for table `course_section_video`
--
ALTER TABLE `course_section_video`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cs_id_for_video` (`course_section`),
  ADD KEY `cs_vid_course_id` (`course`);

--
-- Indexes for table `general_photo`
--
ALTER TABLE `general_photo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instructor_auth_id` (`auth_id`);

--
-- Indexes for table `instructor_assignment_response_remark`
--
ALTER TABLE `instructor_assignment_response_remark`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_remark_instructor` (`instructor`),
  ADD KEY `csec_ass_response_id` (`assignment_response`);

--
-- Indexes for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pt_tag_id` (`tag`),
  ADD KEY `pt_post_id` (`post`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_auth_id` (`auth_id`);

--
-- Indexes for table `student_result`
--
ALTER TABLE `student_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_resulted` (`course`),
  ADD KEY `result_owner` (`acct`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userpost`
--
ALTER TABLE `userpost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `up_creator_id` (`poster`);

--
-- Indexes for table `userpost_comment`
--
ALTER TABLE `userpost_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_commented_id` (`post`),
  ADD KEY `post_commenter_id` (`commenter`);

--
-- Indexes for table `userpost_comment_reply`
--
ALTER TABLE `userpost_comment_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ucr_replyer_id` (`replyer_id`),
  ADD KEY `ucr_comment_id` (`comment_id`);

--
-- Indexes for table `vlab`
--
ALTER TABLE `vlab`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acct`
--
ALTER TABLE `acct`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `acct_transaction`
--
ALTER TABLE `acct_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `course_assignment`
--
ALTER TABLE `course_assignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_assignment_response`
--
ALTER TABLE `course_assignment_response`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_discuss`
--
ALTER TABLE `course_discuss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_discuss_reply`
--
ALTER TABLE `course_discuss_reply`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_enrolment`
--
ALTER TABLE `course_enrolment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `course_instructor`
--
ALTER TABLE `course_instructor`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_quiz`
--
ALTER TABLE `course_quiz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_review`
--
ALTER TABLE `course_review`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_section`
--
ALTER TABLE `course_section`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `course_section_audio`
--
ALTER TABLE `course_section_audio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_section_doc`
--
ALTER TABLE `course_section_doc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_section_video`
--
ALTER TABLE `course_section_video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_photo`
--
ALTER TABLE `general_photo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `instructor_assignment_response_remark`
--
ALTER TABLE `instructor_assignment_response_remark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_tag`
--
ALTER TABLE `post_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_result`
--
ALTER TABLE `student_result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userpost`
--
ALTER TABLE `userpost`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `userpost_comment`
--
ALTER TABLE `userpost_comment`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userpost_comment_reply`
--
ALTER TABLE `userpost_comment_reply`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vlab`
--
ALTER TABLE `vlab`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acct_transaction`
--
ALTER TABLE `acct_transaction`
  ADD CONSTRAINT `acct_in_transaction` FOREIGN KEY (`acct`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_auth_id` FOREIGN KEY (`auth_id`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_assignment`
--
ALTER TABLE `course_assignment`
  ADD CONSTRAINT `csec_id` FOREIGN KEY (`course_section`) REFERENCES `course_section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_assignment_response`
--
ALTER TABLE `course_assignment_response`
  ADD CONSTRAINT `csec_ass_id` FOREIGN KEY (`assignment`) REFERENCES `course_assignment` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_discuss`
--
ALTER TABLE `course_discuss`
  ADD CONSTRAINT `course_discussed` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `course_section_discussed` FOREIGN KEY (`course_section`) REFERENCES `course_section` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `discussion_sender_id` FOREIGN KEY (`sender`) REFERENCES `acct` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `course_discuss_reply`
--
ALTER TABLE `course_discuss_reply`
  ADD CONSTRAINT `course_discuss_id` FOREIGN KEY (`course_discuss`) REFERENCES `course_discuss` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `discussion_replyer_id` FOREIGN KEY (`replyer`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_enrolment`
--
ALTER TABLE `course_enrolment`
  ADD CONSTRAINT `acct_enrolling` FOREIGN KEY (`acct`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `course_enrolled_in` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_instructor`
--
ALTER TABLE `course_instructor`
  ADD CONSTRAINT `course_instructing` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `course_instructor_id` FOREIGN KEY (`instructor`) REFERENCES `instructor` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_quiz`
--
ALTER TABLE `course_quiz`
  ADD CONSTRAINT `c_for_quiz` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `csection_id` FOREIGN KEY (`course_section`) REFERENCES `course_section` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `course_review`
--
ALTER TABLE `course_review`
  ADD CONSTRAINT `course_reviewed` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `course_reviewer_id` FOREIGN KEY (`reviewer`) REFERENCES `acct` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `course_section`
--
ALTER TABLE `course_section`
  ADD CONSTRAINT `course_sectioned` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_section_audio`
--
ALTER TABLE `course_section_audio`
  ADD CONSTRAINT `cs_id_for_audio` FOREIGN KEY (`course_section`) REFERENCES `course_section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_section_doc`
--
ALTER TABLE `course_section_doc`
  ADD CONSTRAINT `cs_id_for_doc` FOREIGN KEY (`course_section`) REFERENCES `course_section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `course_section_video`
--
ALTER TABLE `course_section_video`
  ADD CONSTRAINT `cs_id_for_video` FOREIGN KEY (`course_section`) REFERENCES `course_section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `cs_vid_course_id` FOREIGN KEY (`course`) REFERENCES `course` (`id`);

--
-- Constraints for table `instructor`
--
ALTER TABLE `instructor`
  ADD CONSTRAINT `instructor_auth_id` FOREIGN KEY (`auth_id`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `instructor_assignment_response_remark`
--
ALTER TABLE `instructor_assignment_response_remark`
  ADD CONSTRAINT `assignment_remark_instructor` FOREIGN KEY (`instructor`) REFERENCES `course_instructor` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `csec_ass_response_id` FOREIGN KEY (`assignment_response`) REFERENCES `course_assignment_response` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD CONSTRAINT `pt_post_id` FOREIGN KEY (`post`) REFERENCES `userpost` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pt_tag_id` FOREIGN KEY (`tag`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_auth_id` FOREIGN KEY (`auth_id`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `student_result`
--
ALTER TABLE `student_result`
  ADD CONSTRAINT `course_resulted` FOREIGN KEY (`course`) REFERENCES `course` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `result_owner` FOREIGN KEY (`acct`) REFERENCES `acct` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `userpost`
--
ALTER TABLE `userpost`
  ADD CONSTRAINT `up_creator_id` FOREIGN KEY (`poster`) REFERENCES `acct` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `userpost_comment`
--
ALTER TABLE `userpost_comment`
  ADD CONSTRAINT `post_commented_id` FOREIGN KEY (`post`) REFERENCES `userpost` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `post_commenter_id` FOREIGN KEY (`commenter`) REFERENCES `acct` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `userpost_comment_reply`
--
ALTER TABLE `userpost_comment_reply`
  ADD CONSTRAINT `ucr_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `userpost_comment` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `ucr_replyer_id` FOREIGN KEY (`replyer_id`) REFERENCES `acct` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
