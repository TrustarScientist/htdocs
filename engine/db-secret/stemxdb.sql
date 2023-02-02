-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2023 at 11:41 PM
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
  `description` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `niche`
--

INSERT INTO `niche` (`id`, `name`, `alias`, `date`, `rank`, `parent`, `description`) VALUES
(1, 'WEST AFRICAN EXAMINATION COUNCIL AND RELATED MATTERS ', '@waec', '2023-01-16', 3, 2, 'for waec stuff'),
(2, 'GENERAL INFORMATION SAFE FOR ALL HUMANS', '@www', '2023-01-02', 5, NULL, 'all human knowledge base'),
(3, 'SOFTWARE DEVELOPMENT', '@softdev', '2023-01-02', 1, 2, 'software dev shaaaaa');

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
(1, 1, 2, '2023-02-06'),
(2, 2, 2, '2023-02-27');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` varchar(128) DEFAULT NULL,
  `category` smallint(5) UNSIGNED DEFAULT NULL,
  `poster` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `slug` varchar(225) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `content_type` smallint(6) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `uuid`, `category`, `poster`, `type`, `title`, `date_created`, `date_updated`, `slug`, `content`, `views`, `content_type`) VALUES
(1, NULL, 2, 1, NULL, 'Welcome to the Knowledge-Sharing App', '2023-01-28 05:41:57', '2023-01-28 05:41:57', 'Welcome-to-the-Knowledge-Sharing-App', 'The Knowledge sharing idea was conceived in the early morning of Christmas 2021. And after a year, it was implemented successfully...despite so such delays and inconveniences.', 35508, 1),
(2, NULL, 3, 1, NULL, 'How to learn Software Development Effectively: 3 Tips', '2023-01-28 05:41:57', '2023-01-28 05:41:57', 'How-to-Learn-Software-Development-Effectively:-3-Tips', 'Software Development turns out to be more than the six figures you see online: its a mistery.\r\n', 45, 1),
(3, NULL, 1, 2, NULL, 'How Useful is WAEC Certificate Internationally Really?', '2023-01-28 05:55:53', '2023-01-28 05:55:53', 'How-Useful-is-WAEC-Certificate-Internationally-Really?', 'Why I go get to abroad and still sit for SAT or IETS or GCSE to boost my career. ', 7566, 1),
(6, NULL, 1, 2, NULL, 'WHERE IS WAEC HEADQUARTERS SITUATED?', '2023-01-29 16:02:10', '2023-01-29 16:02:10', 'WHERE-IS-WAEC-HEADQUARTERS-SITUATED?', 'I feel like it should be in Ghana...but I still don\'t know  why Nigeria tends to dominate the discussions around  it. This is particularly obvious as  far as examination malpractices are concerned.', 0, 1),
(7, NULL, 3, 2, NULL, 'JAVASCRIPT: THEN AND NOW', '2023-01-29 16:02:10', '2023-01-29 16:02:10', 'JAVASCRIPT:-THEN-AND-NOW', 'The JavaScript programming language was perceived, initially, as a toy language that people with  not-so-cool skills found interesting. But today, it is a big deal:  from everything web to embedded systems. Wow!  \r\nNothing should be underestimated really.', 353, 1),
(8, NULL, 3, 8, NULL, 'blablabla', '2023-01-29 16:16:22', '2023-01-29 16:16:22', 'blablabla', 'blablablablablablablablablablablabla blablablablablablablablablablablablablablablablablabla blablablablablabla', 111, 1),
(9, NULL, 1, 6, NULL, 'HOW TO KNOW WHETHER A GIRL TRUELY LOVES YOU OR JUST PRETENDING: 5 WAYS.', '2023-01-29 16:32:39', '2023-01-29 16:32:39', 'WAEC-WHAT?', 'I could remember that fateful period I was writing the exam. It was  really stressful', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `post_comment`
--

CREATE TABLE `post_comment` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `uuid` varchar(128) DEFAULT NULL,
  `commenter` int(10) UNSIGNED DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updted` datetime DEFAULT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_comment`
--

INSERT INTO `post_comment` (`id`, `uuid`, `commenter`, `date_created`, `date_updted`, `post`, `content`) VALUES
(1, NULL, 2, '2023-01-29 03:50:10', '2023-01-29 03:50:10', 3, 'What a comment I\'m giving you'),
(2, NULL, 6, '2023-01-29 03:50:10', '2023-01-29 03:50:10', 2, 'well well well'),
(3, NULL, 8, '2023-01-29 03:52:15', '2023-01-29 03:52:15', 1, 'ehehjheje ew ee'),
(4, NULL, 1, '2023-01-29 03:52:54', '2023-01-29 03:52:54', 2, 'vfdshd dkewkwe eweew'),
(5, NULL, 7, '2023-01-29 11:14:21', '2023-01-29 11:14:21', 3, 'whatever'),
(6, NULL, 6, '2023-01-29 11:14:22', '2023-01-29 11:14:22', 3, 'hummm o choke!');

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
(1, 2, 2, '2023-01-16'),
(2, 1, 7, '2023-01-16'),
(3, 1, 8, '2023-01-09'),
(4, 1, 6, '2023-01-31');

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
(1, 3, 'love1.PNG'),
(2, 6, 'christiana-1.jpg'),
(3, 9, 'ope-1.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `post_type`
--

CREATE TABLE `post_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password` varchar(225) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `work_info` varchar(500) DEFAULT NULL,
  `relationship` char(1) DEFAULT NULL,
  `school_info` varchar(500) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `photo` varchar(128) DEFAULT '/static/images/user2.png',
  `intro` varchar(225) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `hobbies` varchar(128) DEFAULT NULL,
  `date_registered` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `phone_number`, `password`, `first_name`, `last_name`, `nationality`, `work_info`, `relationship`, `school_info`, `dob`, `photo`, `intro`, `gender`, `hobbies`, `date_registered`) VALUES
(1, 'TrustarScientist', 'TrustarScientist@gmail.com', '836383629272', 'ncj%%vd38&%*^$GGFW&ghwqi8((*^%', 'Godday', 'Daniel', 'Nigeria', 'I work  @ the Geneticks Computer Institute as a programming teacher...for now! ', 'm', 'I attended Excellent Glory College at 0-Level. And I am studing Computer Science @ the National Open University of Nigeria.', '1996-08-12', 'default photo', 'I am a science-oriented computer programmer, Instructor and lover of music.', 'm', 'creativity, soccer, singing', '2023-01-31'),
(2, 'Phychemma', 'phychemma@gmail.com', '8575433629272', 'ncj%%vd38&%*^$7fy5c9c54&ghwqi8((*^%', 'Emmanuel', 'Ahibi', 'Nigeria', 'I work  @ the Geneticks Computer Institute as a programming teacher...for now! ', 'm', 'I attended jhfheeeer at 0-Level. And I am studing Computer Science @ the National Open University of Nigeria.', '1996-08-12', 'default photo', 'I am a philosophy beleiver', 'm', 'creativity, soccer, singing', '2023-01-31'),
(6, 'TheStoryTeller', 'TheStoryTeller@gmail.com', '86537656677979', 'nby87523739387932h^&%*&W', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-31'),
(7, 'Angel Mercy', 'angelmercy@gmail.com', '8866544678', 'ggahh$$^FW%VW@ug', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-31'),
(8, 'Bolu', 'bolu@gmail.com', '5543465768', '8#@^CU%', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-31');

-- --------------------------------------------------------

--
-- Table structure for table `user_connection`
--

CREATE TABLE `user_connection` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender` int(10) UNSIGNED DEFAULT NULL,
  `receiver` int(10) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `read` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indexes for table `post_type`
--
ALTER TABLE `post_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_typed` (`post`),
  ADD KEY `content_typed` (`type`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_connection`
--
ALTER TABLE `user_connection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `connector` (`sender`),
  ADD KEY `connectee` (`receiver`);

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
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `niche_membership`
--
ALTER TABLE `niche_membership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `post_comment`
--
ALTER TABLE `post_comment`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post_comment_reply`
--
ALTER TABLE `post_comment_reply`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_followership`
--
ALTER TABLE `post_followership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `post_image`
--
ALTER TABLE `post_image`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `post_type`
--
ALTER TABLE `post_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_connection`
--
ALTER TABLE `user_connection`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_msg`
--
ALTER TABLE `user_msg`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_network`
--
ALTER TABLE `user_network`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `post_type`
--
ALTER TABLE `post_type`
  ADD CONSTRAINT `content_typed` FOREIGN KEY (`type`) REFERENCES `contenttype` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  ADD CONSTRAINT `post_typed` FOREIGN KEY (`post`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_connection`
--
ALTER TABLE `user_connection`
  ADD CONSTRAINT `connectee` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `connector` FOREIGN KEY (`sender`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
