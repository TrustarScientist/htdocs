-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2023 at 01:28 AM
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
(2, 'Fact'),
(3, 'Comedy'),
(4, 'Personal'),
(5, 'Question'),
(6, 'Tutorial'),
(7, 'Review');

-- --------------------------------------------------------

--
-- Table structure for table `editor_post_image`
--

CREATE TABLE `editor_post_image` (
  `id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `editor_post_image`
--

INSERT INTO `editor_post_image` (`id`, `path`, `post`) VALUES
(64, 'TrustarScientist-x323l1111d43-IMG_20221116_150424_807.jpg', 76),
(68, 'TrustarScientist-t191914M38n1313-IMG_20221123_154531_507.jpg', 76),
(69, 'TrustarScientist-t1919n1313m1212-IMG_20221019_145711_991.jpg', 78),
(71, 'TrustarScientist-c329R4325B27-alimat-pic1.jpg', 79),
(73, 'TrustarScientist-14M38x323b21-ksharer.PNG', 80),
(74, 'TrustarScientist-z25258S4422E30-love1.PNG', 64),
(75, 'TrustarScientist-18I3412O402Y50-324676518_1375110879961053_397594343425318778_n.jpg', 82),
(76, 'TrustarScientist-m121226A265V47-FB_IMG_16806287735825840.jpg', 52),
(77, 'Ovie-n1313r171712O40-resized_logo_UQww2soKuUsjaOGNB38o.png', 83),
(79, 'Solomon-e5423D2922E30-FB_IMG_16823296210647305.jpg', 91),
(81, 'TrustarScientist-i88g66e54-love2.PNG', 92),
(82, 'TrustarScientist-16K36v212126A26-17213690_img20230507233437_686_jpeg9e58b35a8695ca324855ed37aa6fcaef.jpeg', NULL),
(83, 'TrustarScientist-7T4513N391Z51-nishant.PNG', 42),
(84, 'TrustarScientist-18I3424C2823D29-IMG-20230514-WA0002.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `niche`
--

CREATE TABLE `niche` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `alias` varchar(12) DEFAULT NULL,
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
(7, 'INFORMATION BENEFICIAL AND SAVE FOR ALL HUMANS IN EVERY NATION ON EARTH', '@worldwide', '2023-03-27', NULL, NULL, 'This niche(also called community) is designed to discuss issues related to every human regardless their race, gender, and other factors that differentiate them. And for this reason, we will always pay attention to this niche for integrity and safety reasons.', '/static/images/pexels-felix-mittermeier-956999.jpg'),
(8, 'EDUCATION AND ASSOCIATED TOPICS (INSTITUTIONS, POLICIES, LEARNERS, STAFF ETC.)', '@edu', '2023-03-27', NULL, 7, 'This community focuses on topics and issues related to the acquisition, distribution and processing of the world\'s knowledge base. ', '/static/images/banner-right-image.png'),
(9, 'AGRICULTURE AND OTHER THINGS HUMANS NEED TO FEED ON TO LIVE', '@agro', '2023-03-27', NULL, 7, 'This community is for discusions there promote better ways we can help humanity feed to live. We are naturally gonna die without food !', '/static/images/banner-right-image.png'),
(10, 'INFORMATION FOR MEDICAL CARE', '@healthcare', '2023-03-27', NULL, 7, 'This community focuses on issues and checks geared towards making humans live as healthy as possible', '/static/images/banner-right-image.png'),
(11, 'MOVEMENT OF PEOPLE AND OTHER ASSOCIATED ENTITES', '@travel', '2023-03-27', NULL, 7, 'This commmunity is to discuss things associated with the movement of people. These include vehicle, laws, styles, specs, destinations etc.', '/static/images/banner-right-image.png'),
(12, 'ENERGY (OIL & GAS, ELECTRICALS)', '@energy', '2023-03-27', NULL, 7, 'This community focuses on topics and issues related to the pricing, policies, news, tutorials, among other things that we humans ultimately rely on for our smooth day-to-day activities.', '/static/images/banner-right-image.png'),
(13, 'HUMANS STAYING SAVE AND SECURE', '@security', '2023-03-27', NULL, 7, 'This community to make anyone get updated on threats, tricks used by criminals, potential terorists\' attacks etc.', '/static/images/banner-right-image.png'),
(14, 'FINANCIALS ASPECT OF THINGS INVOLVING HUMANS ', '@finance', '2023-03-27', NULL, 7, 'This community discusses issues related to  financials updates, economy, and businesses', '/static/images/banner-right-image.png'),
(15, 'STRUCTURES, UPDATES AND PRINCIPLES OF SHELTERS FOR HUMANS', '@building', '2023-03-27', NULL, 7, 'This community is for such topics as real estate, infrastructure, homes (and their prices, locations specs)', '/static/images/banner-right-image.png'),
(16, 'ALL THINGS COMPUTER', '@computing', '2023-03-27', NULL, 7, 'This community is for discussions regarding goal-oriented activity requiring, benefiting from, or creating computing machinery.[1] It includes the study and experimentation of algorithmic processes, and development of both hardware and software. Computing has scientific, engineering, mathematical, technological and social aspects. Major computing disciplines include computer engineering, computer science, cybersecurity, data science, information systems, information technology and software engineering.[2]', '/static/images/banner-right-image.png'),
(17, 'CHEMICAL SUBSTANCES (PARTICULAR MATERIALS) FOR VAROIUS USES', '@chems', '2023-03-27', NULL, 7, 'This community discusses the situations, discoveries, techniques regarding chemical substances on Earth', '/static/images/banner-right-image.png'),
(18, 'TOOLS, MACHINES, EQUIPMENT, ', '@tools', '2023-03-27', NULL, 7, 'This discussion focuses on the pricing, usage, manufacturing, sales...etc. of objects that extend human capabilities', '/static/images/banner-right-image.png'),
(19, 'COMMUNICATION METHODOLOGIES,LINGUISTICS, LANGUAGES ETC.', '@coms', '2023-03-27', NULL, 7, 'This community is geared toward better ways, techniques, tools for effective communication...whether on stage or in private.', '/static/images/banner-right-image.png'),
(20, 'GOVERNANCE, LAWS AND LAW MAKING ANS EXECUTION ENTITIES', '@legality', '2023-03-27', NULL, 7, 'Legal requirements, specifications, tips, proposals, among other things are discussed here', '/static/images/banner-right-image.png'),
(21, 'WASTE MANAGEMENT', '@waste', '2023-03-27', NULL, 7, 'Discussion about human-induced wastes: situations around you, better mechanisms etc', '/static/images/banner-right-image.png'),
(22, 'ENTERTAINMENT & LEISURE', '@ent', '2023-03-27', NULL, 7, 'This community focuses on leisure, sports, recreation etc.', '/static/images/banner-right-image.png'),
(23, 'SPORTS INCLUDING FOOTBALL, BACKET BALL', '@sports', '2023-03-27', NULL, 22, 'sports discussions such as news, tutorials, wiki etc', '/static/images/banner-right-image.png'),
(24, 'GOVERNMENTS OF EVERY SOVERIGN STATE ON EARTH', '@govt', '2023-03-27', NULL, 7, 'Discuss of actions and status of the individual governing body of nations', '/static/images/banner-right-image.png'),
(25, 'POLITICAL PROCESSES AND SITUATION OF GOVERNING BODIES', '@politics', '2023-03-27', NULL, 24, 'Discussions regarding power struggles in nations, companies and other complex entities', '/static/images/banner-right-image.png'),
(26, 'THE NATIONAL OPEN UNIVERSITY OF NIGERIA', '@nou', '2023-03-27', NULL, 8, 'This community is for updating people about the status, actions and procedures at the school', '/static/images/banner-right-image.png'),
(27, 'ROMANTICRELATIONSHIPS', '@romance', '2023-03-27', NULL, 10, 'This is the overall community for interpersonal connections between humans.\r\nBecause of how sensitive and easily complicated this aspect of human can be, we will not appreciate the following:\r\n1) offensive, abusive, nude posts', '/static/images/banner-right-image.png'),
(28, 'EFFECTIVE PARENTING ', '@efp', '2023-03-27', NULL, 10, 'THis community is for discussing situations and methods of parenting .', '/static/images/banner-right-image.png'),
(29, 'WEB DEVELOPMENT(FRONTEND & BACKEND)', '@webdev', '2023-03-27', NULL, 16, 'This space is for web developers, web fans, learners', '/static/images/banner-right-image.png'),
(30, 'CYBERSECURITY', '@cybersec', '2023-03-27', NULL, 13, 'For discussing threats due to the use of computers, networks etc.', '/static/images/banner-right-image.png'),
(31, 'COMPUTER SCIENCE @NOU', '@nouCS', '2023-03-07', NULL, 26, 'for the department of computer science at NOU', '/static/images/banner-right-image.png');

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
(152, 64, 10, '2023-04-02'),
(158, 63, 28, '2023-03-07'),
(161, 67, 7, NULL),
(171, 63, 14, '2023-04-15'),
(175, 68, 7, '2023-04-16'),
(176, 68, 18, '2023-04-18'),
(177, 68, 31, '2023-04-18'),
(178, 63, 31, '2023-04-19'),
(181, 68, 12, '2023-04-20'),
(182, 63, 16, '2023-04-20'),
(186, 63, 12, '2023-04-21'),
(187, 63, 8, '2023-04-21'),
(189, 63, 10, '2023-04-23'),
(190, 69, 7, NULL),
(191, 63, 29, '2023-04-27'),
(192, 68, 25, '2023-04-27'),
(193, 70, 7, NULL);

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
  `next` varchar(128) DEFAULT NULL,
  `visibility` char(3) DEFAULT 'pub',
  `token` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `category`, `poster`, `title`, `date_created`, `date_updated`, `slug`, `content`, `views`, `content_type`, `prev`, `next`, `visibility`, `token`) VALUES
(42, 16, 63, 'Python and Django: How to Use Them', '2023-04-02 12:05:34', '2023-05-12 08:35:15', NULL, '&lt;p&gt;information for performncperformance&amp;nbsp;&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-7T4513N391Z51-nishant.PNG&quot;&gt;&lt;/figure&gt;&lt;p&gt;Python is a general-purpose, interpreted and object oriented computer programming language. It was designed to be particularly easy to code in it. As a general purpose language, it can be used for various tasks such as web development, data ananalytics &amp;nbsp;A.I development, desktop apps etc.&amp;nbsp;&lt;/p&gt;&lt;h4&gt;100 FACTS ABOUT PYTHON&lt;/h4&gt;&lt;ol&gt;&lt;li&gt;It is “batteries-included”. Meaning it is fully loaded with libraries useful in any field you can imagine&amp;nbsp;&lt;/li&gt;&lt;li&gt;It is object-oriented. It models code structures like real world objects.&lt;/li&gt;&lt;li&gt;It is interpreted. Meaning…you don&#039;t have to compile your code before running it.&lt;/li&gt;&lt;/ol&gt;&lt;p&gt;Check other related tutorials here&lt;/p&gt;&lt;p&gt;gif&lt;/p&gt;', 118, 3, NULL, NULL, 'pub', NULL),
(44, 16, 63, 'SELF-TAUGHT PROGRAMMING VS GOING TO SCHOOL', '2023-04-02 14:12:23', '2023-04-27 14:57:03', NULL, '&lt;p&gt;we all come from various backfrounbackgrounds , uphold unique mindset regarding how we learn and acquire skills. Despite these differences, we still have a common goal: to get educated.&amp;nbsp;&lt;/p&gt;&lt;p&gt;But let&#039;s look at two approaches: self-teaching and going to school.&lt;/p&gt;&lt;h3&gt;SELF-TEACHING&lt;/h3&gt;&lt;h4&gt;Pros:&lt;/h4&gt;&lt;ol&gt;&lt;li&gt;you are likely going to be extremely good at it&lt;/li&gt;&lt;li&gt;you are&lt;/li&gt;&lt;/ol&gt;&lt;h3&gt;Con: jviigg8yi&lt;/h3&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;', 15, 7, NULL, NULL, 'pvt', NULL),
(52, 14, 63, 'WHY NIGERIA IS NOT GETTING RICH WITH OIL REVENUE', '2023-04-02 23:42:01', '2023-04-20 12:25:42', NULL, '&lt;ol&gt;&lt;li&gt;CORRUPTION&lt;/li&gt;&lt;li&gt;BAD INFRASTRUCTURE&lt;/li&gt;&lt;li&gt;NATION WIDE INSECURITY&lt;/li&gt;&lt;li&gt;WIDESPREAD ILLITERACY&lt;/li&gt;&lt;li&gt;LOW INVESTMENT IN CRITICAL SECTORSSECTORS&lt;/li&gt;&lt;li&gt;&lt;strong&gt;&lt;img src=&quot;/storage/post/TrustarScientist-m121226A265V47-FB_IMG_16806287735825840.jpg&quot;&gt;&lt;/strong&gt;&lt;/li&gt;&lt;/ol&gt;', 28, 2, NULL, NULL, 'pub', NULL),
(55, 10, 63, 'iuug878', '2023-04-03 19:55:14', '2023-04-20 11:50:00', NULL, '&lt;p&gt;yfyf7&lt;/p&gt;', 3, 1, NULL, NULL, 'pub', NULL),
(56, 26, 63, 'WHAT TO DO WHEN THINGS FALL APART', '2023-04-04 11:41:57', '2023-04-11 11:10:47', NULL, '&lt;p&gt;Just rest your head. &amp;nbsp;wowoowowow!!!!!!!!!!!!&lt;/p&gt;&lt;p&gt;Reflect on your life, mindset and&lt;strong&gt; believe system h&lt;/strong&gt;&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', NULL),
(59, 7, 63, 'driving', '2023-04-04 13:20:25', '2023-04-12 16:29:50', NULL, '&lt;p&gt;driving is a simple way to way to move about.&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', NULL),
(61, 7, 63, 'HOW TO REUSE  BROKEN BOTTLE EASILY', '2023-04-05 16:25:07', '2023-04-11 08:04:07', NULL, '&lt;p&gt;Please check for updates on this &lt;strong&gt;post&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;jjjke oo l21io21&lt;/strong&gt;&lt;/p&gt;', 1, 6, NULL, NULL, 'pub', NULL),
(62, 28, 64, 'HOW TO EDUCATE YOUR KIDS ABOUT SEX', '2023-04-10 22:04:27', '2023-04-10 22:04:27', 'HOW-TO-EDUCATE-YOUR-KIDS-ABOUT-SEX', 'You don\'t have to tell them all at once.', 9, 2, NULL, NULL, 'pub', NULL),
(63, 9, 64, 'WHY ARE CHICKENS SO EXPENSIVE IN LAGOS AND NIGERIA AT LARGE', '2023-04-10 22:04:27', '2023-04-10 22:04:27', NULL, 'I bought some obviously \'weak\' chickens last Easter. After all the cooking stress, I was as if I wasted my money...', 4, 5, NULL, NULL, 'pub', NULL),
(64, 16, 63, 'A NEW POST AFTER EDITOR HACKING ATTEMPT', '2023-04-10 22:55:40', '2023-04-23 00:56:18', NULL, '&lt;p&gt;&lt;strong&gt;qqtqtqtu &amp;nbsp;eje eke ee eee ekehep2h eoewue ewwe ew wekewue9ew ewkewewiw weieie&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;ejewjhew ewkew e the meaning of this statement is not too clear really…&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;i&gt;&lt;strong&gt;&lt;img src=&quot;/storage/post/TrustarScientist-z25258S4422E30-love1.PNG&quot;&gt;&lt;/strong&gt;&lt;/i&gt;&lt;/p&gt;&lt;p&gt;&lt;i&gt;&lt;strong&gt;WHATEWHATEVER &lt;/strong&gt;&lt;/i&gt;…..&lt;/p&gt;&lt;p&gt;by daniel&lt;/p&gt;', 16, 1, NULL, NULL, 'pub', NULL),
(65, 12, 65, 'MOSES THE GREATE', '2023-04-11 07:49:07', '2023-04-11 07:49:07', NULL, 'I AM MOSES OOOOOOOOOOOOOOOOOOO', 3, 4, NULL, NULL, 'pub', NULL),
(82, 12, 63, 'CHRISTIANA MY FARAWAY...', '2023-04-15 17:01:02', '2023-04-19 17:06:12', NULL, '&lt;p&gt;&lt;img src=&quot;/storage/post/TrustarScientist-18I3412O402Y50-324676518_1375110879961053_397594343425318778_n.jpg&quot;&gt;&lt;/p&gt;&lt;p&gt;werfg,hjkll&lt;/p&gt;', 10, 1, NULL, NULL, 'pub', '=#hgghfrt#%'),
(83, 7, 68, 'MY  FIRST OVIE POST', '2023-04-18 15:02:17', '2023-04-19 12:21:09', NULL, '&lt;p&gt;whyyyyyyyy&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/storage/post/Ovie-n1313r171712O40-resized_logo_UQww2soKuUsjaOGNB38o.png&quot;&gt;&lt;/p&gt;&lt;p&gt;YEAH&lt;/p&gt;', 4, 1, NULL, NULL, 'pub', '_?MY  FIRST OVIE POST??'),
(84, 31, 68, 'Intro to @noucs', '2023-04-19 12:23:14', '2023-04-19 13:31:09', NULL, '&lt;h2&gt;computer science students and professional @nou…&lt;/h2&gt;&lt;p&gt;first post in this niche…okay?&lt;/p&gt;', 2265, 1, NULL, NULL, 'pub', '~?into to @noucs!^'),
(85, 12, 63, 'SOME PEOPLE ARE REALLY HUNGARY', '2023-04-19 19:22:31', '2023-04-19 19:22:48', NULL, '&lt;h3&gt;WHAT DOES HUNGER LOOK LIKE?&lt;/h3&gt;&lt;ol&gt;&lt;li&gt;Its like hell on earth&lt;/li&gt;&lt;li&gt;Of course…lose of energy to do something meaningful&lt;/li&gt;&lt;li&gt;loosing one&#039;s hope of the future&lt;/li&gt;&lt;li&gt;become ununnecessarily aggresaggressive&amp;nbsp;&lt;/li&gt;&lt;li&gt;And so on&lt;/li&gt;&lt;/ol&gt;&lt;p&gt;Spoiler Alert: I&#039;m actually hungary…really. I mean It!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!&lt;/p&gt;', 53, 1, NULL, NULL, 'pub', '^%SOME PEOPLE ARE REALLY HUNGARY=%'),
(86, 12, 68, 'My first post @energy', '2023-04-20 12:12:56', '2023-04-20 12:21:22', NULL, '&lt;p&gt;WHY NEPA NO DEY BRING POWER SUPPLY GAN?&lt;/p&gt;&lt;p&gt;i&#039;M SICK &amp;nbsp;AND TIRED…&lt;/p&gt;&lt;p&gt;FOR HOW LONG OVIE SELF?&lt;/p&gt;', 0, 5, NULL, NULL, 'pvt', '!@My first post @energy&&'),
(87, 28, 63, 'MEANING OF LOVE', '2023-04-22 09:29:21', '2023-04-22 09:29:21', NULL, '&lt;p&gt;The statement, “I love you”, is &amp;nbsp;really popular…albeit often misused.&lt;/p&gt;', 2, 1, NULL, NULL, 'pub', '^#MEANING OF LOVE&!'),
(88, 28, 63, 'LEARN DJANGO 4.4 FROM SCRATCH', '2023-04-23 03:04:32', '2023-04-25 17:19:30', NULL, '&lt;p&gt;HJY JY HD56D infoinformation is so important&lt;/p&gt;', 1, 1, NULL, NULL, 'pub', '?!LEARN DJANGO 4.4 FROM SCRATCH$?'),
(89, 28, 63, 'TAKE CARE OF YOUR BEARDS', '2023-04-23 05:04:18', '2023-05-16 12:42:21', NULL, '&lt;p&gt;UY This is a vital information&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;', 3, 1, NULL, NULL, 'pub', '!?TAKE CARE OF YOUR BEARDS@^'),
(90, 16, 63, 'INFORMATION IS KEY', '2023-04-24 14:13:12', '2023-04-24 14:13:24', NULL, '&lt;p&gt;This is just life bro&lt;/p&gt;', 5, 1, NULL, NULL, 'pub', '?^INFORMATION IS KEY#%'),
(91, 7, 69, 'CHRISTIANA MY FARAWAY...', '2023-04-27 15:07:33', '2023-04-27 15:07:33', NULL, '&lt;ul&gt;&lt;li&gt;&lt;i&gt;&lt;strong&gt;Hi Guyz&lt;img src=&quot;/storage/post/Solomon-e5423D2922E30-FB_IMG_16823296210647305.jpg&quot;&gt;&lt;/strong&gt;&lt;/i&gt;&lt;/li&gt;&lt;/ul&gt;', 12, 3, NULL, NULL, 'pub', '^=CHRISTIANA MY FARAWAY...=@'),
(92, 28, 63, 'grap man', '2023-04-27 17:27:22', '2023-04-27 17:27:22', NULL, '&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-i88g66e54-love2.PNG&quot;&gt;&lt;/figure&gt;&lt;p&gt;you fine likethis&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;', 2, 1, NULL, NULL, 'pub', '?@grap man_$');

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
(10, 63, '2023-04-05 15:03:50', NULL, 42, 'Please dont stop talking about Python. And thank you'),
(11, 63, '2023-04-05 15:10:59', NULL, 42, 'nice one'),
(12, 63, '2023-04-05 15:27:46', NULL, 42, 'Add your comment here...'),
(13, 63, '2023-04-05 16:41:57', NULL, 42, 'Commenting is good for this post...'),
(14, 63, '2023-04-05 18:37:10', NULL, 42, 'Wow!!!!!!!!!!!!!!!!!!!!'),
(15, 63, '2023-04-05 18:37:15', NULL, 42, 'Wow!!!!!!!!!!!!!!!!!!!!'),
(16, 63, '2023-04-05 18:37:16', NULL, 42, 'Wow!!!!!!!!!!!!!!!!!!!!'),
(17, 63, '2023-04-05 19:54:56', NULL, 42, 'what?'),
(18, 63, '2023-04-05 19:55:03', NULL, 42, 'why?'),
(19, 63, '2023-04-05 19:55:18', NULL, 42, 'when>>'),
(20, 63, '2023-04-05 19:55:26', NULL, 42, 'when>>'),
(21, 63, '2023-04-05 19:57:08', NULL, 42, 'queen../.,,'),
(22, 63, '2023-04-05 19:57:24', NULL, 42, 'Google'),
(23, 63, '2023-04-05 19:57:25', NULL, 42, 'Add New Comment...'),
(24, 63, '2023-04-05 19:57:27', NULL, 42, 'Add New Comment...'),
(25, 63, '2023-04-05 19:58:48', NULL, 42, 'Add your comment here...'),
(26, 63, '2023-04-05 20:57:36', NULL, 61, 'hiii'),
(27, 63, '2023-04-05 21:10:23', NULL, 52, 'LOL!!!'),
(28, 63, '2023-04-16 12:59:31', NULL, 52, 'good to know'),
(29, 68, '2023-04-16 13:06:17', NULL, 64, 'ovie is commenting'),
(30, 68, '2023-04-18 14:03:43', NULL, 61, 'ggg\n'),
(31, 68, '2023-04-19 12:57:31', NULL, 84, 'thats good!!!'),
(32, 63, '2023-04-19 14:08:48', NULL, 84, 'Too good to be true...'),
(33, 63, '2023-04-19 18:57:49', NULL, 42, 'Thank you for this post'),
(34, 63, '2023-04-19 19:06:15', NULL, 42, 'xerox-situation'),
(35, 63, '2023-04-19 19:18:49', NULL, 42, 'my comment'),
(36, 63, '2023-04-19 19:24:48', NULL, 85, 'I can relate well...'),
(37, 63, '2023-04-25 15:53:55', NULL, 52, 'The man has grass face'),
(38, 63, '2023-04-25 21:53:14', NULL, 42, 'sup sup'),
(39, 63, '2023-04-25 22:06:14', NULL, 82, 'ffff'),
(40, 68, '2023-04-29 16:28:13', NULL, 91, 'Whaaaaaaaaaaaaat?'),
(41, 63, '2023-05-07 21:30:27', NULL, 42, 'Yes ooo ...'),
(42, 63, '2023-05-12 08:37:54', NULL, 92, 'wow'),
(43, 63, '2023-05-12 08:39:04', NULL, 62, 'thank you coach...'),
(44, 68, '2023-05-12 16:10:29', NULL, 42, 'What\'s this now?'),
(45, 63, '2023-05-23 16:15:57', NULL, 64, 'Ehehheh');

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
(7, 31, 65, '2023-03-07', 'You finally say something interesting '),
(8, 31, 67, '2023-03-15', 'We at Dangote believe in this niche too...'),
(9, 32, 63, '2023-03-15', 'yeah!'),
(10, 10, 63, '2023-03-15', 'Ok...no probs'),
(11, 31, 63, '2023-04-19', ''),
(12, 32, 63, '2023-04-19', 'y3y'),
(13, 31, 63, '2023-04-19', 'wowowow....w'),
(14, 31, 63, '2023-04-19', 'queen niche'),
(15, 32, 63, '2023-04-19', 'nice'),
(16, 33, 63, '2023-04-19', 'hmmmm'),
(17, 22, 63, '2023-04-19', 'reww'),
(18, 33, 63, '2023-04-19', 'reply 2'),
(19, 36, 63, '2023-04-19', 'sapa turns out to be real!'),
(20, 36, 63, '2023-04-20', 'good?'),
(21, 33, 63, '2023-04-25', 'supsup'),
(22, 38, 63, '2023-04-25', 'piles '),
(23, 38, 63, '2023-04-27', 'ssd'),
(24, 44, 63, '2023-05-23', 'Ask Google!');

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
(358, 42, 64, '2023-03-07'),
(403, 44, 63, '2023-04-12'),
(410, 65, 63, '2023-04-13'),
(411, 62, 63, '2023-04-13'),
(413, 59, 67, '2023-04-13'),
(414, 61, 63, '2023-04-14'),
(426, 59, 63, '2023-04-16'),
(436, 83, 68, '2023-04-18'),
(439, 61, 68, '2023-04-18'),
(440, 52, 68, '2023-04-19'),
(458, 83, 69, '2023-04-27'),
(460, 84, 69, '2023-04-27'),
(461, 59, 69, '2023-04-27'),
(462, 61, 69, '2023-04-27'),
(470, 91, 68, '2023-04-27'),
(472, 92, 63, '2023-05-07'),
(474, 84, 63, '2023-05-07'),
(475, 83, 63, '2023-05-07'),
(481, 65, 68, '2023-05-11'),
(483, 92, 68, '2023-05-12'),
(485, 42, 68, '2023-05-12'),
(486, 87, 68, '2023-05-12'),
(487, 86, 68, '2023-05-12'),
(491, 87, 63, '2023-05-23'),
(494, 42, 63, '2023-05-23'),
(495, 64, 63, '2023-05-23'),
(496, 88, 63, '2023-05-23'),
(498, 52, 63, '2023-05-23'),
(504, 82, 63, '2023-05-23'),
(507, 55, 63, '2023-05-23'),
(508, 85, 63, '2023-05-23'),
(511, 90, 63, '2023-05-23'),
(512, 82, 68, '2023-05-23'),
(514, 89, 63, '2023-05-29'),
(515, 85, 68, '2023-05-29'),
(516, 83, 70, '2023-05-29'),
(518, 91, 70, '2023-06-01');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT '',
  `phone_number` varchar(15) DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `first_name` varchar(50) DEFAULT '',
  `last_name` varchar(50) DEFAULT '',
  `nationality` varchar(50) DEFAULT '',
  `work_info` varchar(500) DEFAULT '',
  `relationship` char(1) DEFAULT 's',
  `school_info` varchar(500) DEFAULT 'Not Explained Yet',
  `dob` date DEFAULT NULL,
  `photo` varchar(225) DEFAULT 'user2.png',
  `intro` varchar(225) DEFAULT 'Not Written Yet',
  `gender` char(1) DEFAULT 's',
  `hobbies` varchar(128) DEFAULT 'many things',
  `date_registered` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `phone_number`, `password`, `first_name`, `last_name`, `nationality`, `work_info`, `relationship`, `school_info`, `dob`, `photo`, `intro`, `gender`, `hobbies`, `date_registered`) VALUES
(63, 'TrustarScientist', 'dtrustarscientist@gmail.com', '09068655764', '$2y$10$3mRKEQI4Llu01xmZz86SkutQCtN1D/d4dGktYO1iZgH9Itw76sja6', 'Godday', 'Daniel', 'Nigeria', 'I work @demlag as a STEM teacher ', 's', 'Pursuing a bachelor\'s degree @noun', '1996-08-12', 'TrustarScientist-6U46i88l1111-16848511949246561049256994326601.jpg', 'I am a Backend software developer. I love to use Node(JavaScript), Django(Python) and Golang for my works. Any thing information technology', 'm', 'Coding, Listening to music, teaching...', '2023-03-25'),
(64, 'TheStoryTeller', 'mojisolachristabel@gmail.com', '39030328932', '$2y$10$p2ICE0khamkMx93T3cicQuhVH/WV0LxPGCfPnBHunWgN27fYEWvZa', '', '', '', '', 's', 'Not Explained Yet', NULL, 'user2.png', 'Not Written Yet', 'f', 'many things', '2023-03-25'),
(65, 'Mosesdavid', 'hannahalicia45@gmail.com', '09075812027', '$2y$10$nd.kg73NctoHkg6yBjFvTe6cib6hyJBONSmxkxnXh4UNtL9QRXxEO', '', '', '', '', 's', 'Not Explained Yet', NULL, 'user2.png', 'Genius in information technology ', 'm', 'many things', '2023-04-06'),
(67, 'DangoteCementPlc', 'dangotecementplc@gmail.com', '8161818431', '$2y$10$hfPcbjhmxgmaoujKzqLaluSe/s6Hcay15GsW.qBfeuFy4REgTxgLy', '', '', '', '', 's', 'Not Explained Yet', NULL, 'user2.png', 'information about the dangote cement company', 's', 'many things', '2023-04-13'),
(68, 'Ovie', 'ovie@gmail.com', '08055830851', '$2y$10$qSR4vbsYJXlUZXMu.5FWXuehMX8ZFM.H6.W0fdzT29xwb8P7cdpGS', 'starBoy', 'matthew', '', '', 's', 'Not Explained Yet', '2007-07-05', 'Ovie-1Z51f558S44-GettyImages-1341306825-2b5c1fcf42324ed0bd13d78b5eb316da.webp', 'Not Written Yet', 'm', 'many things', '2023-04-16'),
(69, 'Solomon', 'solomonolokunola9@gmail.com', '08135826411', '$2y$10$D2M5.oETmv3BP0iD.mn.UeO/oF5ZZ5C7QGZ02F7gDAlE6cWcNNo6a', 'Solomon', 'Olokunola', 'Nigeria', '', 's', 'Engineering', '2000-05-04', 'Solomon-24C283X493X49-FB_IMG_16821623670486139.jpg', 'Always feel cool and Happy', 'm', 'Dancing, 🥁 Drumming', '2023-04-27'),
(70, 'EGC', 'egs@gmail.com', '', '$2y$10$bhkhDXQyRjNzZGYA2zcaXu/xlhVYsgLGMd.HVFNKgEjm2NHQSoENO', '', '', '', '', 's', 'Not Explained Yet', NULL, 'user2.png', 'Not Written Yet', 's', 'many things', '2023-05-29');

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
(18, 63, 65, '2023-04-20'),
(19, 69, 68, '2023-04-27');

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

--
-- Dumping data for table `user_connection`
--

INSERT INTO `user_connection` (`id`, `sender`, `receiver`, `date`, `state`) VALUES
(125, 63, 67, '2023-04-20', '0'),
(132, 69, 68, '2023-04-27', '0'),
(133, 69, 65, '2023-04-27', '0');

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
(260, 63, 64, '2023-04-09'),
(265, 68, 64, '2023-04-18'),
(266, 68, 67, '2023-04-18'),
(267, 68, 68, '2023-04-19'),
(269, 63, 68, '2023-04-21'),
(272, 69, 69, '2023-04-27'),
(276, 68, 63, '2023-04-27'),
(281, 63, 69, '2023-05-16'),
(282, 63, 63, '2023-05-23');

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
(218, 64, 63, '2023-04-09 23:49:31', 'My Bro how are you?', '0'),
(219, 65, 63, '2023-04-10 00:18:02', 'Hi sir', '0'),
(220, 63, 65, '2023-04-10 09:06:28', 'Boooooo', '0'),
(221, 63, 65, '2023-04-16 08:55:23', 'Ygggggggggggggyyyyyyyuhhhhhhhuuuuuuuh', '0'),
(222, 68, 64, '2023-04-19 08:55:29', '\n                        ', '0'),
(223, 68, 64, '2023-04-19 09:07:14', '\n                        ', '0'),
(224, 68, 64, '2023-04-19 09:07:32', '\n                        ', '0'),
(225, 68, 64, '2023-04-19 09:09:35', 'ok oooo', '0'),
(226, 68, 64, '2023-04-19 09:09:43', 'qququy', '0'),
(227, 68, 64, '2023-04-19 09:11:19', 'hwhjewhew', '0'),
(228, 68, 63, '2023-04-20 13:01:27', 'Hello Mr. Dan', '0'),
(229, 63, 68, '2023-04-21 07:48:51', 'whatever ', '0'),
(230, 63, 68, '2023-04-21 08:41:39', 'Shh', '0'),
(231, 63, 68, '2023-04-21 10:08:51', 'drake...oooooooooooooo', '0'),
(232, 63, 69, '2023-04-27 14:52:26', 'Hi Solomon!', '0'),
(233, 69, 63, '2023-04-27 14:53:04', 'Hi how are you hope all is well and fine ', '0'),
(234, 69, 63, '2023-04-27 14:54:03', 'Queen...', '0'),
(235, 69, 63, '2023-04-27 14:55:14', 'Hope family is good and fine ok 🥰🥰🥰', '0'),
(236, 63, 68, '2023-04-27 17:15:30', 'xdfcgvhfcjvkhgv', '0'),
(237, 68, 63, '2023-04-27 17:22:17', 'wath  they fuck are you saying', '0'),
(238, 63, 68, '2023-05-07 20:59:54', 'Heh', '0'),
(239, 63, 69, '2023-05-12 08:31:24', 'ehhhh', '0'),
(240, 63, 69, '2023-05-16 12:38:57', 'It\'s been long we talked...', '0'),
(242, 63, 70, '2023-05-29 12:22:18', 'Why do you really want this friendship?', '0');

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
(69, '2023-04-27', 69, 63),
(70, '2023-04-27', 63, 68),
(71, '2023-05-29', 63, 70);

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
-- Indexes for table `editor_post_image`
--
ALTER TABLE `editor_post_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `niche`
--
ALTER TABLE `niche`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `alias` (`alias`),
  ADD KEY `parent_niche_id` (`parent`);
ALTER TABLE `niche` ADD FULLTEXT KEY `name` (`name`,`alias`,`description`);

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
  ADD KEY `poster_id` (`poster`),
  ADD KEY `content` (`content`(225));
ALTER TABLE `post` ADD FULLTEXT KEY `title` (`title`,`content`);

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
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);
ALTER TABLE `user` ADD FULLTEXT KEY `username_2` (`username`,`first_name`,`last_name`,`work_info`,`school_info`,`intro`,`hobbies`);

--
-- Indexes for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blocker_id` (`blocker`),
  ADD KEY `blocked_user_id` (`blocked`);

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
-- AUTO_INCREMENT for table `editor_post_image`
--
ALTER TABLE `editor_post_image`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `niche`
--
ALTER TABLE `niche`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `niche_membership`
--
ALTER TABLE `niche_membership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `post_comment`
--
ALTER TABLE `post_comment`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `post_comment_reply`
--
ALTER TABLE `post_comment_reply`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `post_followership`
--
ALTER TABLE `post_followership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=519;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_connection`
--
ALTER TABLE `user_connection`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `user_likeness`
--
ALTER TABLE `user_likeness`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=283;

--
-- AUTO_INCREMENT for table `user_msg`
--
ALTER TABLE `user_msg`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- AUTO_INCREMENT for table `user_network`
--
ALTER TABLE `user_network`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

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
-- Constraints for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  ADD CONSTRAINT `blocked_user_id` FOREIGN KEY (`blocked`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `blocker_id` FOREIGN KEY (`blocker`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
