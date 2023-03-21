-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2023 at 09:36 PM
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
-- Database: `stemxdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `contenttype`
--

CREATE TABLE `contenttype` (
  `id` smallint(6) NOT NULL,
  `name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contenttype`
--

INSERT INTO `contenttype` (`id`, `name`) VALUES
(1, 'News'),
(2, 'Encyclopedia '),
(3, 'Humor'),
(4, 'Personal'),
(5, 'Question'),
(6, 'Tutorial'),
(7, 'Review');

-- --------------------------------------------------------

--
-- Table structure for table `niche`
--

CREATE TABLE `niche` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `alias` varchar(9) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `rank` smallint(6) DEFAULT NULL,
  `parent` smallint(5) UNSIGNED DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `banner` varchar(128) DEFAULT '/static/images/banner-right-image.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `niche`
--

INSERT INTO `niche` (`id`, `name`, `alias`, `date`, `rank`, `parent`, `description`, `banner`) VALUES
(1, 'WEST AFRICAN EXAMINATION COUNCIL AND RELATED MATTERS ', '@waec', '2023-01-16', 3, 2, 'for waec stuff', '/static/images/eni.jpg'),
(2, 'GENERAL INFORMATION SAFE FOR ALL HUMANS', '@www', '2023-01-02', 5, NULL, 'all human knowledge base', '/static/images/download (3).jpg'),
(3, 'SOFTWARE DEVELOPMENT', '@softdev', '2023-01-02', 1, 2, 'software dev shaaaaa', '/static/images/banner-right-image.png'),
(4, 'GOOGLE RELATED NEWS', '@google', '2023-02-13', 10, 2, 'This page is for discussion Google, inc. news, products, updates etc.', '/static/images/banner-right-image.png'),
(5, 'NIGERIAN NEWS', '@naija', '2023-02-13', 8, 2, 'Updates on what\'s going on in Nigeria', '/static/images/banner-right-image.png'),
(6, 'EFFECTIVE PARENTING FOR 21ST CENTURY KIDS', '@efp', '2023-02-15', 1, 2, 'This is niche to discuss how parents can better manage their kids in a modern way...yet still succeed in it. The niche is for coaches, parents, and to some extent, their kids.', '/static/images/banner-right-image.png');

-- --------------------------------------------------------

--
-- Table structure for table `niche_membership`
--

CREATE TABLE `niche_membership` (
  `id` int(10) UNSIGNED NOT NULL,
  `member` int(10) UNSIGNED DEFAULT NULL,
  `niche` smallint(5) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `niche_membership`
--

INSERT INTO `niche_membership` (`id`, `member`, `niche`, `date`) VALUES
(2, 2, 2, '2023-02-27'),
(4, 47, 2, '2023-02-09'),
(5, 47, 3, '2023-02-20'),
(10, 47, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(10) UNSIGNED NOT NULL,
  `category` smallint(5) UNSIGNED DEFAULT NULL,
  `poster` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `slug` varchar(225) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `content_type` smallint(6) DEFAULT 1,
  `prev` varchar(128) DEFAULT NULL,
  `next` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `category`, `poster`, `title`, `date_created`, `date_updated`, `slug`, `content`, `views`, `content_type`, `prev`, `next`) VALUES
(3, 1, 2, 'How Useful is WAEC Certificate Internationally Really?', '2023-01-28 05:55:53', '2023-01-28 05:55:53', 'How-Useful-is-WAEC-Certificate-Internationally-Really?', 'Why I go get to abroad and still sit for SAT or IETS or GCSE to boost my career.     document.querySelector(\".poster #photo\").src = `/storage/profile/${res.poster.photo}`;\r\n            let userLink = document.querySelector(\".poster .name a\");\r\n            userLink.href = `/user/${res.poster.username}`;\r\n            userLink.textContent = res.poster.username;\r\n            document.querySelector(\".poster .more .date\").textContent = res.date_updated;\r\n            let niche = document.querySelector(\".post-stats .niche\");\r\n            niche.href = `/niche/${res.category.alias}`;\r\n            niche.textContent = res.category.alias;\r\n            let postThumbnail = document.querySelector(\".post-main-pic\");\r\n            // if the poster did not attach any photos, use the niche banner instead for the thumbnail\r\n            if  }', 882, 4, 'post-id-here', 'next post'),
(6, 1, 2, 'WHERE IS WAEC HEADQUARTERS SITUATED?', '2023-01-29 16:02:10', '2023-01-29 16:02:10', 'WHERE-IS-WAEC-HEADQUARTERS-SITUATED?', 'I feel like it should be in Ghana...but I still don\'t know  why Nigeria tends to dominate the discussions around  it. This is particularly obvious as  far as examination malpractices are concerned.', 31, 5, NULL, NULL),
(7, 3, 2, 'JAVASCRIPT: THEN AND NOW', '2023-01-29 16:02:10', '2023-01-29 16:02:10', 'JAVASCRIPT:-THEN-AND-NOW', 'The JavaScript programming language was perceived, initially, as a toy language that people with  not-so-cool skills found interesting. But today, it is a big deal:  from everything web to embedded systems. Wow!  \r\nNothing should be underestimated really.', 372, 1, NULL, NULL),
(8, 3, 8, 'blablabla', '2023-01-29 16:16:22', '2023-01-29 16:16:22', 'blablabla', 'blablablablablablablablablablablabla blablablablablabllablablablablabla blablablablablabla', 121, 1, NULL, NULL),
(9, 1, 6, 'HOW TO KNOW WHETHER A GIRL TRUELY LOVES YOU OR JUST PRETENDING: 5 WAYS.', '2023-01-29 16:32:39', '2023-01-29 16:32:39', 'WAEC-WHAT?', 'I could remember that fateful period I was writing the exam. It was  really stressful', 15, 6, NULL, NULL),
(10, 3, 51, 'Who is Mr. Chuks?', '2023-02-24 23:00:16', '2023-02-24 23:00:16', 'Who-is-Mr.-Chuks?', 'Mr. Chuks is a sophisticated frontend web developer. His real name is Emeka...I don\'t know his surname.', 28, 7, NULL, NULL),
(11, 2, 7, 'Five Tips to Become a Great Human', '2023-02-24 23:00:16', '2023-02-24 23:00:16', 'Five-Tips-to-Become-a-Great-Human', '1) Love yourself.\r\n2) Show love towards humans like you.\r\n3) Humble yourself even if you know much.', 77, 4, NULL, NULL),
(12, 1, 49, 'WAEC 2023 EXAM DATE', '2023-03-03 00:47:12', '2023-03-03 00:47:12', 'WAEC-2023-EXAM-DATE', 'the exam will commence in August 5. Okay?', 10, 4, NULL, NULL),
(13, 4, 8, 'HOW GOOGLE CHANGED THE WEB WITH THE CHROMIUM ENGINE', '2023-03-05 03:20:17', '2023-03-05 03:20:17', 'HOW-GOOGLE-CHANGED-THE-WEB-WITH-THE-CHROMIUM-ENGINE', 'The Chromium Engine was carefully architected to be:\r\n1) Insanely performant.\r\n2) Robust Enough to withstand modern workload.\r\n3) Make really App-like functionalities on the Web. \r\nWoooooow!!!', 10, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post_comment`
--

CREATE TABLE `post_comment` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `commenter` int(10) UNSIGNED DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_comment`
--

INSERT INTO `post_comment` (`id`, `commenter`, `date_created`, `date_updated`, `post`, `content`) VALUES
(1, 2, '2023-01-29 03:50:10', '2023-01-29 03:50:10', 3, 'What a comment I\'m giving you. Don\'t worry it is not a real commen - it\'s just a template.'),
(5, 7, '2023-01-29 11:14:21', '2023-01-29 11:14:21', 3, 'whatever'),
(6, 6, '2023-01-29 11:14:22', '2023-01-29 11:14:22', 3, 'hummm o choke!'),
(7, NULL, '2023-02-28 01:11:41', '2023-02-28 01:11:41', 3, 'I think I like the flow of this comment system.\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `post_comment_reply`
--

CREATE TABLE `post_comment_reply` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `comment` smallint(5) UNSIGNED DEFAULT NULL,
  `replyer` int(10) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_comment_reply`
--

INSERT INTO `post_comment_reply` (`id`, `comment`, `replyer`, `date`, `content`) VALUES
(3, 1, 40, '2023-02-06', 'reply 1'),
(4, 1, 2, '2023-02-07', 'reply 2... I gat no time.'),
(6, 5, 51, '2023-01-16', 'really?');

-- --------------------------------------------------------

--
-- Table structure for table `post_followership`
--

CREATE TABLE `post_followership` (
  `id` int(10) UNSIGNED NOT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `follower` int(10) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_followership`
--

INSERT INTO `post_followership` (`id`, `post`, `follower`, `date`) VALUES
(10, 3, 50, NULL),
(11, 3, 7, NULL),
(12, 3, 38, '2023-02-13'),
(97, 13, 47, '2023-03-06'),
(107, 11, 47, '2023-03-07'),
(111, 13, 52, '2023-03-08'),
(113, 11, 52, '2023-03-08'),
(115, 8, 52, '2023-03-08'),
(118, 9, 52, '2023-03-08'),
(123, 13, 53, '2023-03-08'),
(128, 6, 54, '2023-03-08'),
(129, 3, 49, '2023-03-08'),
(133, 10, 51, '2023-03-08'),
(134, 9, 54, '2023-03-08'),
(139, 7, 47, '2023-03-08'),
(140, 7, 52, '2023-03-08'),
(142, 3, 52, '2023-03-11'),
(143, 12, 47, '2023-03-13');

-- --------------------------------------------------------

--
-- Table structure for table `post_image`
--

CREATE TABLE `post_image` (
  `id` int(10) UNSIGNED NOT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_image`
--

INSERT INTO `post_image` (`id`, `post`, `path`) VALUES
(1, 3, 'Zad-Cairo.jpg'),
(2, 6, 'christiana-1.jpg'),
(3, 9, 'ope-1.jpg'),
(4, 3, 'ope-1.jpg'),
(5, 3, 'mmm.png'),
(6, 3, 'ccf.png');

-- --------------------------------------------------------

--
-- Table structure for table `post_video`
--

CREATE TABLE `post_video` (
  `id` int(10) UNSIGNED NOT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `video_path` varchar(128) DEFAULT NULL,
  `caption` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `post_video`
--

INSERT INTO `post_video` (`id`, `post`, `video_path`, `caption`) VALUES
(1, 3, 'https://youtu.be/BePArgUjkss', 'MOre content about the video embedded or conclusive statements can be here...especially if you work with videos...ok that\'s weird. THe whole idea is to make the post details page render content as it were structure with a powerful WYSIWYG Editor. This is because we are still working on our minimalistic editor');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT '',
  `last_name` varchar(50) DEFAULT '',
  `nationality` varchar(50) DEFAULT NULL,
  `work_info` varchar(500) DEFAULT NULL,
  `relationship` char(1) DEFAULT NULL,
  `school_info` varchar(500) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `photo` varchar(128) DEFAULT 'user2.png',
  `intro` varchar(225) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `hobbies` varchar(128) DEFAULT NULL,
  `date_registered` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `phone_number`, `password`, `first_name`, `last_name`, `nationality`, `work_info`, `relationship`, `school_info`, `dob`, `photo`, `intro`, `gender`, `hobbies`, `date_registered`) VALUES
(2, 'Phychemma', 'phychemma@gmail.com', '8575433629272', 'ncj%%vd38&%*^$7fy5c9c54&ghwqi8((*^%', 'Emmanuel', 'Ahibi', 'Nigeria', 'I work  @ the Geneticks Computer Institute as a programming teacher...for now! ', 'm', 'I attended jhfheeeer at 0-Level. And I am studing Computer Science @ the National Open University of Nigeria.', '1996-08-12', 'user2.png', 'I am a philosophy beleiver', 'm', 'creativity, soccer, singing', '2023-01-31'),
(6, 'TheStoryTeller', 'TheStoryTeller@gmail.com', '86537656677979', 'nby87523739387932h^&%*&W', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'moji.jpg', NULL, NULL, NULL, '2023-01-31'),
(7, 'AngelMercy', 'angelmercy@gmail.com', '8866544678', 'ggahh$$^FW%VW@ug', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'angel-mercy.jpg', NULL, NULL, NULL, '2023-01-31'),
(8, 'Bolu', 'bolu@gmail.com', '5543465768', '8#@^CU%', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, NULL, NULL, '2023-01-31'),
(38, 'God', 'dtrustarscientist@gmail.com', '', '$2y$10$VH0OEXRMmhLyU21ZRx1KMenRiccgQCl0tMHNab9RL7ct2ODbMx2jm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'm', NULL, '2023-02-03'),
(39, 'Wema', 'phychemma4@gmail.com', '9449434846464', '$2y$10$NoC0fXVSgEHXPkAWnlEc0OW7hqryKKFBYHsb/49qSOHMlZq5JHDcW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'm', NULL, '2023-02-04'),
(40, 'naira', 'naira@gmail.com', '12345678910', '$2y$10$o8TWf3oIw7TNaOGz1u7w3eL7At2ZoYPMOCgXAge5RGN7/chzMKdim', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 's', NULL, '2023-02-04'),
(47, 'drakee', 'drakee@gmail.com', '34873479389', '$2y$10$AIJoU8TsekEnVviVFgGozOxisFvLZ1lfYKV50iZHXgWOdytHo15QS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'client-img.png', NULL, 'm', NULL, '2023-02-05'),
(48, 'reg', 'reg@gmail.com', '8378348739', '$2y$10$EyZIfkeEUJr.4m83f5CsROvjD8SD7xSNsir.VsKY7olGZYGDObpKC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 's', NULL, '2023-02-23'),
(49, 'oluwajuwon', 'oluwajuwonogunlana28@gmail.com', '07055352456', '$2y$10$j/X/QrXAh3Uv7feQOENHMOcUXNNYDCU0rxp52XlI1IDvLJSUPgWK.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'm', NULL, '2023-02-24'),
(50, 'Adex boy', 'adeyemimiracle57@gmail.com', '08109516698', '$2y$10$rdpS1TFglQ5zr/WIAdRdmeouZTp8wWiDED2vxPBtPTVZpIkbuQQoi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'm', NULL, '2023-02-24'),
(51, 'Chuks', 'lekwaemeka70@gmail.com', '08113528708', '$2y$10$y9cBlRWRB0Ja/WKHpm37puylrbbkzB5ERVHrMLy4Hha/GAESET4aS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'm', NULL, '2023-02-24'),
(52, 'TrustarScientist', 'dtrustarscientist@gmail.com', '09068655764', '$2y$10$TuzR2.0CBUczIVz0YJf3R.D8OghpdL5KbI2942aZ4QH7lQQusDsBS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'intelligent.jpg', NULL, 'm', NULL, '2023-03-05'),
(53, 'Eniola', 'solomonwuraolaeniola@gmail.com', '08118129899', '$2y$10$oFQbaE3H8Z1YCy8RNFpMpetAHlMJnfNb9wFSJNMJZZdFB6S2VId/6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'f', NULL, '2023-03-08'),
(54, 'Adeyemi ', 'adeyemimiracle57@gmail.com', '08109516698', '$2y$10$cI55R9A71DjI6LHOx9nMROTOFqsayopz5/JI1eXiSt4pYACVP72ey', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 'm', NULL, '2023-03-08'),
(56, 'EGC', 'egs@gmail.com', '39030328932', '$2y$10$kQ9NpGA135iL6ogI9zEND.HxpRrYT3ab6KfpZMBiH8jQegxDf76Ny', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'user2.png', NULL, 's', NULL, '2023-03-12'),
(57, 'AUD', 'aud@gmail.com', '83237928723', '$2y$10$XrhxE6XI5OiZRtbh/hSbw.zwhpWhQQ/AKbmgSfyMWhs7EeLs1g5Hy', '', '', NULL, NULL, NULL, NULL, NULL, 'user2.png', 'The Ansarudeen Primary School', 's', NULL, '2023-03-13');

-- --------------------------------------------------------

--
-- Table structure for table `user_blacklist`
--

CREATE TABLE `user_blacklist` (
  `id` int(10) UNSIGNED NOT NULL,
  `blocker` int(10) UNSIGNED NOT NULL,
  `blocked` int(10) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_blacklist`
--

INSERT INTO `user_blacklist` (`id`, `blocker`, `blocked`, `date`) VALUES
(41, 47, 49, '2023-03-07'),
(44, 47, 8, '2023-03-07'),
(54, 47, 2, '2023-03-08'),
(60, 52, 2, '2023-03-11');

-- --------------------------------------------------------

--
-- Table structure for table `user_connection`
--

CREATE TABLE `user_connection` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender` int(10) UNSIGNED DEFAULT NULL,
  `receiver` int(10) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL,
  `state` char(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_likeness`
--

CREATE TABLE `user_likeness` (
  `id` int(10) UNSIGNED NOT NULL,
  `liker` int(10) UNSIGNED NOT NULL,
  `liked` int(10) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_likeness`
--

INSERT INTO `user_likeness` (`id`, `liker`, `liked`, `date`) VALUES
(78, 56, 52, '2023-03-22'),
(82, 56, 57, '2023-03-16'),
(83, 57, 52, '2023-03-07'),
(85, 57, 2, '2023-03-13');

-- --------------------------------------------------------

--
-- Table structure for table `user_msg`
--

CREATE TABLE `user_msg` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender` int(10) UNSIGNED DEFAULT NULL,
  `receiver` int(10) UNSIGNED DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `body` varchar(1000) DEFAULT NULL,
  `is_read` char(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_msg`
--

INSERT INTO `user_msg` (`id`, `sender`, `receiver`, `datetime`, `body`, `is_read`) VALUES
(31, 47, 52, '2023-03-11 23:57:36', 'Hey Trustar!', '1'),
(32, 47, 52, '2023-03-11 23:57:40', 'I am the one u spoke to @geneticks for web3 stuff', '0'),
(33, 47, 53, '2023-03-12 00:02:19', 'Enibug...wow', '0'),
(34, 47, 52, '2023-03-12 00:02:19', 'Please reply to my messages...pls', '0'),
(35, 47, 52, '2023-03-12 00:48:39', 'Don\'t worry...I will just let go of my dreams...thanks to you!', '0'),
(36, 52, 47, '2023-03-12 01:40:34', 'Baba Blu...', '0'),
(37, 8, 52, '2023-03-12 03:13:42', 'Bolu never forgets promises!', '0'),
(38, 51, 52, '2023-03-12 03:14:27', 'Mr. Daniel...I want to ask...are you coming to Geneticks today?', '0'),
(39, 53, 52, '2023-03-12 03:21:39', 'Hello Mr. Dan. Do we have lecture today? Cuz I can not just come early and sit, waiting for hours for everyone to come.', '0'),
(40, 51, 52, '2023-03-12 03:28:53', 'And the XAMPP thing...me I no understand.', '0'),
(41, 7, 52, '2023-03-12 04:59:24', 'Hey Bro Dan!', '0'),
(42, 48, 52, '2023-03-12 05:13:51', 'I just registered on this platform', '0'),
(43, 39, 52, '2023-03-12 05:13:53', 'Wema is back', '0'),
(44, 7, 52, '2023-03-12 05:36:07', 'What\'s up now?', '0'),
(45, 7, 52, '2023-03-12 05:36:09', 'You said you wanted to see me', '0'),
(46, 54, 52, '2023-03-12 05:38:23', 'Mr. Dan I have entered bug again o', '0'),
(47, 54, 52, '2023-03-12 05:38:24', 'I don\'t know why my page is overflowing beyond the screen width.', '0'),
(48, 40, 52, '2023-03-12 05:44:45', 'I gat Bitcoin tutorials ', '0'),
(49, 40, 52, '2023-03-12 05:44:47', 'I am an accredited agent...so you can trust me.', '0'),
(50, 2, 52, '2023-03-12 06:01:52', 'I don\'t know why bugs are kind of tricky', '0'),
(51, 2, 52, '2023-03-12 06:01:53', 'Well they are my bug!', '0'),
(52, 7, 52, '2023-03-12 06:05:40', 'I am just bored right now', '0'),
(53, 53, 52, '2023-03-12 06:14:43', 'Mr. Dan I can no longer do that assignment you gave us', '0'),
(54, 8, 52, '2023-03-12 06:16:41', 'Bolu ti de', '0'),
(55, 51, 52, '2023-03-12 06:17:40', 'jkkeiheiu', '0'),
(56, 49, 52, '2023-03-12 06:21:30', 'Trustar', '0'),
(57, 54, 52, '2023-03-12 06:23:09', 'Why u no answer me Mr. Dan?', '0'),
(58, 49, 52, '2023-03-12 06:23:15', 'TrustarScientist', '0'),
(59, 49, 52, '2023-03-12 06:24:00', 't-older', '0'),
(60, 47, 52, '2023-03-12 06:25:01', 't-newer', '0'),
(61, 7, 52, '2023-03-12 08:10:29', 'Are you hiding something from me?', '0'),
(62, 7, 52, '2023-03-12 08:10:31', 'By the way did you send some messages to me?', '0'),
(63, 7, 52, '2023-03-12 08:18:26', 'Because...of my God...', '0'),
(64, 7, 52, '2023-03-12 08:18:27', 'I don\'t even understand some things', '0'),
(65, 7, 52, '2023-03-12 08:20:55', 'Like...I mean...', '0'),
(66, 7, 52, '2023-03-12 08:24:34', 'Ok can I ask you a funny question?', '0'),
(67, 7, 52, '2023-03-12 08:24:36', 'Do you like me?', '0'),
(68, 8, 52, '2023-03-12 08:31:39', 'I have finally finish my JAMB oooo Mr. Dan', '0'),
(69, 8, 52, '2023-03-12 08:46:45', 'I\'m so happy right now', '0'),
(70, 51, 52, '2023-03-12 08:49:55', 'This JavaScript thing me I no understand o', '0'),
(71, 51, 52, '2023-03-12 08:49:58', 'like which one is for in, for of, foreach', '0'),
(72, 51, 52, '2023-03-12 08:52:02', 'why the several for loop codes?', '0'),
(73, 51, 52, '2023-03-12 08:52:04', 'Like when should i use which one?', '0'),
(74, 47, 52, '2023-03-12 10:31:24', 'Wow wow wow!!!', '0'),
(75, 8, 52, '2023-03-12 10:39:27', 'gjgj', '0'),
(76, 54, 52, '2023-03-12 10:40:10', 'ade1', '0'),
(77, 54, 52, '2023-03-12 10:40:12', 'ade2', '0'),
(78, 51, 52, '2023-03-12 10:44:48', 'chucks1', '0'),
(79, 40, 52, '2023-03-12 10:46:42', 'narai', '0'),
(80, 53, 52, '2023-03-12 10:51:14', 'blablablu 1 of Africa', '0'),
(81, 53, 53, '2023-03-12 11:39:18', 'Mr. Dan', '0'),
(82, 49, 52, '2023-03-12 11:41:32', 'Ola', '0'),
(83, 38, 52, '2023-03-12 11:42:11', 'Code of Conduct', '0'),
(84, 38, 52, '2023-03-12 11:42:12', 'Forgotten so soon?', '0'),
(85, 52, 47, '2023-03-12 12:09:22', 'jhgty', '0'),
(86, 52, 47, '2023-03-12 12:13:21', 'what is up now?', '0'),
(87, 52, 47, '2023-03-12 12:13:54', 'uuyt', '0'),
(88, 52, 47, '2023-03-12 12:14:15', '6776', '0'),
(89, 52, 47, '2023-03-12 12:14:24', 'zfer', '0'),
(90, 52, 47, '2023-03-12 12:14:46', 'wow', '0'),
(92, 52, 47, '2023-03-12 12:20:55', 'wow&#039;s', '0'),
(93, 52, 47, '2023-03-12 12:21:18', 'queen', '0'),
(94, 52, 47, '2023-03-12 12:21:28', 'queenx', '0'),
(95, 52, 47, '2023-03-12 12:21:45', 'what&#039;s up now?', '0'),
(96, 52, 47, '2023-03-12 12:33:21', 'what\'s up now? ', '0'),
(97, 52, 47, '2023-03-12 12:34:19', 'I said, \"what\'s up now? \".', '0'),
(98, 52, 47, '2023-03-12 12:35:23', 'Whatever', '0'),
(99, 52, 47, '2023-03-12 12:43:56', 'drake', '0');

-- --------------------------------------------------------

--
-- Table structure for table `user_network`
--

CREATE TABLE `user_network` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL,
  `user1` int(10) UNSIGNED DEFAULT NULL,
  `user2` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_network`
--

INSERT INTO `user_network` (`id`, `date`, `user1`, `user2`) VALUES
(27, NULL, 54, 56),
(29, '2023-03-08', 52, 57);

-- --------------------------------------------------------

--
-- Table structure for table `user_notification`
--

CREATE TABLE `user_notification` (
  `id` int(10) UNSIGNED NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `destination_url` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contenttype`
--
ALTER TABLE `contenttype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `niche`
--
ALTER TABLE `niche`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `alias` (`alias`),
  ADD KEY `parent_niche_id` (`parent`);

--
-- Indexes for table `niche_membership`
--
ALTER TABLE `niche_membership`
  ADD PRIMARY KEY (`id`),
  ADD KEY `niche_member_id` (`member`),
  ADD KEY `said_niche_id` (`niche`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `niche_posted_in_id` (`category`),
  ADD KEY `poster_id` (`poster`);

--
-- Indexes for table `post_comment`
--
ALTER TABLE `post_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commenter_id` (`commenter`),
  ADD KEY `post_commented_id` (`post`);

--
-- Indexes for table `post_comment_reply`
--
ALTER TABLE `post_comment_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comment_replied_id` (`comment`),
  ADD KEY `replyer_id` (`replyer`);

--
-- Indexes for table `post_followership`
--
ALTER TABLE `post_followership`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_followed` (`post`),
  ADD KEY `post_follower` (`follower`);

--
-- Indexes for table `post_image`
--
ALTER TABLE `post_image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posted_in` (`post`);

--
-- Indexes for table `post_video`
--
ALTER TABLE `post_video`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_having_video` (`post`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_blocking` (`blocker`),
  ADD KEY `user_blocked` (`blocked`);

--
-- Indexes for table `user_connection`
--
ALTER TABLE `user_connection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `connector` (`sender`),
  ADD KEY `connectee` (`receiver`);

--
-- Indexes for table `user_likeness`
--
ALTER TABLE `user_likeness`
  ADD PRIMARY KEY (`id`),
  ADD KEY `liker_id` (`liker`),
  ADD KEY `liked_id` (`liked`);

--
-- Indexes for table `user_msg`
--
ALTER TABLE `user_msg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `msg_sender_id` (`sender`),
  ADD KEY `msg_receiver_id` (`receiver`);

--
-- Indexes for table `user_network`
--
ALTER TABLE `user_network`
  ADD PRIMARY KEY (`id`),
  ADD KEY `u1` (`user1`),
  ADD KEY `u2` (`user2`);

--
-- Indexes for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contenttype`
--
ALTER TABLE `contenttype`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `niche`
--
ALTER TABLE `niche`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `niche_membership`
--
ALTER TABLE `niche_membership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `post_comment`
--
ALTER TABLE `post_comment`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `post_comment_reply`
--
ALTER TABLE `post_comment_reply`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post_followership`
--
ALTER TABLE `post_followership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `post_image`
--
ALTER TABLE `post_image`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `post_video`
--
ALTER TABLE `post_video`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `user_connection`
--
ALTER TABLE `user_connection`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `user_likeness`
--
ALTER TABLE `user_likeness`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `user_msg`
--
ALTER TABLE `user_msg`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `user_network`
--
ALTER TABLE `user_network`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `user_notification`
--
ALTER TABLE `user_notification`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `niche`
--
ALTER TABLE `niche`
  ADD CONSTRAINT `parent_niche_id` FOREIGN KEY (`parent`) REFERENCES `niche` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `niche_membership`
--
ALTER TABLE `niche_membership`
  ADD CONSTRAINT `niche_member_id` FOREIGN KEY (`member`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `said_niche_id` FOREIGN KEY (`niche`) REFERENCES `niche` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `niche_posted_in_id` FOREIGN KEY (`category`) REFERENCES `niche` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `poster_id` FOREIGN KEY (`poster`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post_comment`
--
ALTER TABLE `post_comment`
  ADD CONSTRAINT `commenter_id` FOREIGN KEY (`commenter`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `post_commented_id` FOREIGN KEY (`post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post_comment_reply`
--
ALTER TABLE `post_comment_reply`
  ADD CONSTRAINT `comment_replied_id` FOREIGN KEY (`comment`) REFERENCES `post_comment` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `replyer_id` FOREIGN KEY (`replyer`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post_followership`
--
ALTER TABLE `post_followership`
  ADD CONSTRAINT `post_followed` FOREIGN KEY (`post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `post_follower` FOREIGN KEY (`follower`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post_image`
--
ALTER TABLE `post_image`
  ADD CONSTRAINT `posted_in` FOREIGN KEY (`post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `post_video`
--
ALTER TABLE `post_video`
  ADD CONSTRAINT `post_having_video` FOREIGN KEY (`post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  ADD CONSTRAINT `user_blocked` FOREIGN KEY (`blocked`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_blocking` FOREIGN KEY (`blocker`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_connection`
--
ALTER TABLE `user_connection`
  ADD CONSTRAINT `connectee` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `connector` FOREIGN KEY (`sender`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_likeness`
--
ALTER TABLE `user_likeness`
  ADD CONSTRAINT `liked_id` FOREIGN KEY (`liked`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `liker_id` FOREIGN KEY (`liker`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_msg`
--
ALTER TABLE `user_msg`
  ADD CONSTRAINT `msg_receiver_id` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `msg_sender_id` FOREIGN KEY (`sender`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_network`
--
ALTER TABLE `user_network`
  ADD CONSTRAINT `u1` FOREIGN KEY (`user1`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `u2` FOREIGN KEY (`user2`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
