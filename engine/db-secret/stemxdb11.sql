-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2023 at 06:27 AM
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
(73, 'TrustarScientist-14M38x323b21-ksharer.PNG', 80);

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
(7, 'INFORMATION BENEFICIAL AND SAVE FOR ALL HUMANS IN EVERY NATION ON EARTH', '@worldwide', '2023-03-27', NULL, NULL, 'This niche(also called community) is designed to discuss issues related to every human regardless their race, gender, and other factors that differentiate them. And for this reason, we will always pay attention to this niche for integrity and safety reasons.', '/static/images/banner-right-image.png'),
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
(30, 'CYBERSECURITY', '@cybersec', '2023-03-27', NULL, 13, 'For discussing threats due to the use of computers, networks etc.', '/static/images/banner-right-image.png');

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
(151, 63, 12, '2023-03-22'),
(152, 64, 10, '2023-04-02'),
(153, 63, 9, '2023-04-03'),
(154, 63, 7, '2023-04-10'),
(155, 63, 14, '2023-04-08');

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
(42, 12, 63, 'Python and Django: How to Use Them', '2023-04-02 12:05:34', '2023-04-04 12:28:31', NULL, '&lt;p&gt;updated2&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-10Q42f5525B27-1.2-Python-Django_-What-and-why_.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;Python is a general-purpose, interpreted and object oriented computer programming language. It was designed to be particularly easy to code in it. As a general purpose language, it can be used for various tasks such as web development, data ananalytics &amp;nbsp;A.I development, desktop apps etc.&amp;nbsp;&lt;/p&gt;&lt;h4&gt;100 FACTS ABOUT PYTHON&lt;/h4&gt;&lt;ol&gt;&lt;li&gt;It is “batteries-included”. Meaning it is fully loaded with libraries useful in any field you can imagine&amp;nbsp;&lt;/li&gt;&lt;li&gt;It is object-oriented. It models code structures like real world objects.&lt;/li&gt;&lt;li&gt;It is interpreted. Meaning…you don&#039;t have to compile your code before running it.&lt;/li&gt;&lt;/ol&gt;&lt;p&gt;Check other related tutorials here&lt;/p&gt;', 7, 3, NULL, NULL, 'pub', NULL),
(44, 26, 63, 'SELF-TAUGHT PROGRAMMING VS GOING TO SCHOOL', '2023-04-02 14:12:23', '2023-04-03 19:56:07', NULL, '&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-e54h7712O40-1661918309741.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;we all come from various backfrounbackgrounds , uphold unique mindset regarding how we learn and acquire skills. Despite these differences, we still have a common goal: to get educated.&amp;nbsp;&lt;/p&gt;&lt;p&gt;But let&#039;s look at two approaches: self-teaching and going to school.&lt;/p&gt;&lt;h3&gt;SELF-TEACHING&lt;/h3&gt;&lt;h4&gt;Pros:&lt;/h4&gt;&lt;ol&gt;&lt;li&gt;you are likely going to be extremely good at it&lt;/li&gt;&lt;li&gt;you&amp;nbsp;&lt;/li&gt;&lt;/ol&gt;&lt;h3&gt;Con: jviigg8yi&lt;/h3&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;', 3, 7, NULL, NULL, 'pvt', NULL),
(52, 12, 63, 'WHY NIGERIA IS NOT GETTING RICH WITH OIL REVENUE', '2023-04-02 23:42:01', '2023-04-04 12:58:40', NULL, '&lt;ol&gt;&lt;li&gt;CORRUPTION&lt;/li&gt;&lt;li&gt;BAD INFRASTRUCTURE&lt;/li&gt;&lt;li&gt;NATION WIDE INSECURITY&lt;/li&gt;&lt;li&gt;WIDESPREAD ILLITERACY&lt;/li&gt;&lt;li&gt;LOW INVESTMENT IN CRITICAL SECTORS&lt;/li&gt;&lt;/ol&gt;', 3, 2, NULL, NULL, 'pub', NULL),
(55, 13, 63, 'iuug878', '2023-04-03 19:55:14', '2023-04-03 19:55:14', NULL, '&lt;p&gt;yfyf7&lt;/p&gt;', 1, 1, NULL, NULL, 'pub', NULL),
(56, 26, 63, 'WHAT TO DO WHEN THINGS FALL APART', '2023-04-04 11:41:57', '2023-04-11 11:10:47', NULL, '&lt;p&gt;Just rest your head. &amp;nbsp;wowoowowow!!!!!!!!!!!!&lt;/p&gt;&lt;p&gt;Reflect on your life, mindset and&lt;strong&gt; believe system h&lt;/strong&gt;&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', NULL),
(59, 9, 63, 'driving', '2023-04-04 13:20:25', '2023-04-11 11:41:10', NULL, '&lt;p&gt;driving is a simple way to way to move about.&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-20G3226A26f55-shopping.webp&quot;&gt;&lt;/figure&gt;&lt;p&gt;wow25&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', NULL),
(61, 7, 63, 'HOW TO REUSE  BROKEN BOTTLE EASILY', '2023-04-05 16:25:07', '2023-04-11 08:04:07', NULL, '&lt;p&gt;Please check for updates on this &lt;strong&gt;post&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;jjjke oo l21io21&lt;/strong&gt;&lt;/p&gt;', 0, 6, NULL, NULL, 'pub', NULL),
(62, 28, 64, 'HOW TO EDUCATE YOUR KIDS ABOUT SEX', '2023-04-10 22:04:27', '2023-04-10 22:04:27', 'HOW-TO-EDUCATE-YOUR-KIDS-ABOUT-SEX', 'You don\'t have to tell them all at once.', 0, 2, NULL, NULL, 'pub', NULL),
(63, 9, 64, 'WHY ARE CHICKENS SO EXPENSIVE IN LAGOS AND NIGERIA AT LARGE', '2023-04-10 22:04:27', '2023-04-10 22:04:27', NULL, 'I bought some obviously \'weak\' chickens last Easter. After all the cooking stress, I was as if I wasted my money...', 0, 5, NULL, NULL, 'pub', NULL),
(64, 26, 63, 'A NEW POST AFTER EDITOR HACKING ATTEMPT', '2023-04-10 22:55:40', '2023-04-10 22:55:40', NULL, '&lt;p&gt;&lt;i&gt;&lt;strong&gt;WHATEWHATEVER &lt;/strong&gt;&lt;/i&gt;…..&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', NULL),
(65, 12, 65, 'MOSES THE GREATE', '2023-04-11 07:49:07', '2023-04-11 07:49:07', NULL, 'I AM MOSES OOOOOOOOOOOOOOOOOOO', 0, 4, NULL, NULL, 'pub', NULL),
(67, 26, 63, 'iiewo', '2023-04-11 19:11:53', '2023-04-11 19:11:53', NULL, '&lt;p&gt;&lt;strong&gt;ekleroi&lt;/strong&gt;&lt;/p&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-8S44a1016K36-IMG_20220903_094239_278.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;Love is waht again?&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h2&gt;&lt;strong&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616j9911P41-IMG_20220904_153436_769.jpg&quot;&gt;&lt;/strong&gt;&lt;/h2&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616n13131Z51-IMG_20220913_133653_159.jpg&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '#iiewo~'),
(68, 26, 63, 'iiewo', '2023-04-11 19:14:42', '2023-04-11 19:14:42', NULL, '&lt;p&gt;&lt;strong&gt;ekleroi&lt;/strong&gt;&lt;/p&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-8S44a1016K36-IMG_20220903_094239_278.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;Love is waht again?&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h2&gt;&lt;strong&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616j9911P41-IMG_20220904_153436_769.jpg&quot;&gt;&lt;/strong&gt;&lt;/h2&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616n13131Z51-IMG_20220913_133653_159.jpg&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '_iiewo#'),
(69, 26, 63, 'iiewo', '2023-04-11 19:15:41', '2023-04-11 19:15:41', NULL, '&lt;p&gt;&lt;strong&gt;ekleroi&lt;/strong&gt;&lt;/p&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-8S44a1016K36-IMG_20220903_094239_278.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;Love is waht again?&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h2&gt;&lt;strong&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616j9911P41-IMG_20220904_153436_769.jpg&quot;&gt;&lt;/strong&gt;&lt;/h2&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616n13131Z51-IMG_20220913_133653_159.jpg&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '?iiewo?'),
(70, 26, 63, 'iiewo4', '2023-04-11 19:18:06', '2023-04-11 19:18:06', NULL, '&lt;p&gt;&lt;strong&gt;ekleroi&lt;/strong&gt;&lt;/p&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-8S44a1016K36-IMG_20220903_094239_278.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;p&gt;Love is waht again?&lt;/p&gt;&lt;p&gt;&amp;nbsp;&lt;/p&gt;&lt;h2&gt;&lt;strong&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616j9911P41-IMG_20220904_153436_769.jpg&quot;&gt;&lt;/strong&gt;&lt;/h2&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-q1616n13131Z51-IMG_20220913_133653_159.jpg&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '$$iiewo4&*'),
(71, 26, 63, 'test post1', '2023-04-11 19:26:59', '2023-04-11 19:26:59', NULL, '&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-g6619H33g66-IMG_20220903_094239_278.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;test 1&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '**test post1*@'),
(72, 26, 63, 'test post 2', '2023-04-11 19:31:11', '2023-04-11 19:31:11', NULL, '&lt;p&gt;djwugew&lt;/p&gt;&lt;figure class=&quot;image image-style-side&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-19H33p1515d43-IMG_20220903_105918_815.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;ewhjhew&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '?~test post 2!*'),
(73, 26, 63, 'test post 3', '2023-04-11 19:33:46', '2023-04-11 19:33:46', NULL, '&lt;p&gt;keieyi&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-c3210Q42k1010-IMG_20220914_200648_659.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;what a boy!!!&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '#?test post 3%$'),
(74, 26, 63, 'test post 3', '2023-04-11 19:35:01', '2023-04-11 19:35:01', NULL, '&lt;p&gt;keieyi&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-c3210Q42k1010-IMG_20220914_200648_659.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;what a boy!!!&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '*=test post 3#='),
(75, 26, 63, 'test post 3', '2023-04-11 19:35:20', '2023-04-11 19:35:20', NULL, '&lt;p&gt;keieyi&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-c3210Q42k1010-IMG_20220914_200648_659.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;what a boy!!!&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '_&test post 3=*'),
(76, 7, 63, 'practical post 1', '2023-04-11 19:38:29', '2023-04-12 05:13:03', NULL, '&lt;p&gt;what a practical post&lt;img src=&quot;/storage/post/TrustarScientist-x323l1111d43-IMG_20221116_150424_807.jpg&quot;&gt;&lt;/p&gt;&lt;p&gt;ureuueriuier&lt;/p&gt;&lt;p&gt;let encencrypt though…&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-t191914M38n1313-IMG_20221123_154531_507.jpg&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '*?practical post 1__'),
(77, 26, 63, 'prank 1', '2023-04-11 20:54:25', '2023-04-11 20:54:25', NULL, '&lt;p&gt;eklekoi3&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '_%prank 1~#'),
(78, 7, 63, 'prank 2', '2023-04-11 20:55:06', '2023-04-12 05:18:53', NULL, '&lt;p&gt;ejje 2iu32u32 23i23u&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-t1919n1313m1212-IMG_20221019_145711_991.jpg&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '?@prank 2=='),
(79, 12, 63, 'a new post 1', '2023-04-12 05:51:13', '2023-04-12 05:51:13', NULL, '&lt;p&gt;wejkewjkew&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-c329R4325B27-alimat-pic1.jpg&quot;&gt;&lt;/figure&gt;&lt;p&gt;ewejwewe&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '^@a new post 1$@'),
(80, 12, 63, 'new post 2', '2023-04-12 05:54:16', '2023-04-12 05:54:16', NULL, '&lt;p&gt;qquu&lt;/p&gt;&lt;p&gt;weew&lt;/p&gt;&lt;figure class=&quot;image&quot;&gt;&lt;img src=&quot;/storage/post/TrustarScientist-14M38x323b21-ksharer.PNG&quot;&gt;&lt;/figure&gt;', 0, 1, NULL, NULL, 'pub', '$^new post 2!&'),
(81, 12, 63, 'a zero-image post', '2023-04-12 06:22:26', '2023-04-12 06:22:26', NULL, '&lt;p&gt;I SAID NO MORE POST…..&lt;/p&gt;', 0, 1, NULL, NULL, 'pub', '*!a zero-image post*=');

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
(27, 63, '2023-04-05 21:10:23', NULL, 52, 'LOL!!!');

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
(358, 42, 64, '2023-03-07'),
(359, 42, 63, '2023-04-10'),
(363, 62, 63, '2023-04-10'),
(366, 63, 63, '2023-04-11'),
(367, 61, 63, '2023-04-11'),
(378, 55, 63, '2023-04-11'),
(380, 64, 63, '2023-04-11'),
(381, 56, 63, '2023-04-11'),
(382, 79, 63, '2023-04-12'),
(385, 80, 63, '2023-04-12'),
(386, 77, 63, '2023-04-12'),
(387, 76, 63, '2023-04-12'),
(388, 68, 63, '2023-04-12'),
(389, 81, 63, '2023-04-12');

-- --------------------------------------------------------

--
-- Table structure for table `post_image`
--

CREATE TABLE `post_image` (
  `id` int(10) UNSIGNED NOT NULL,
  `post` int(10) UNSIGNED DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(63, 'TrustarScientist', 'dtrustarscientist@gmail.com', '09068655764', '$2y$10$3mRKEQI4Llu01xmZz86SkutQCtN1D/d4dGktYO1iZgH9Itw76sja6', '', '', '', '', 's', 'Not Explained Yet', '0000-00-00', 'TrustarScientist-v2121m12127T45-1661918309741.jpg', 'Not Written Yet', 'm', 'many things', '2023-03-25'),
(64, 'TheStoryTeller', 'mojisolachristabel@gmail.com', '39030328932', '$2y$10$p2ICE0khamkMx93T3cicQuhVH/WV0LxPGCfPnBHunWgN27fYEWvZa', '', '', '', '', 's', 'Not Explained Yet', NULL, 'user2.png', 'Not Written Yet', 'f', 'many things', '2023-03-25'),
(65, 'Mosesdavid', 'hannahalicia45@gmail.com', '09075812027', '$2y$10$nd.kg73NctoHkg6yBjFvTe6cib6hyJBONSmxkxnXh4UNtL9QRXxEO', '', '', '', '', 's', 'Not Explained Yet', NULL, 'user2.png', 'Not Written Yet', 'm', 'many things', '2023-04-06');

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
(6, 63, 65, '2023-04-11');

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
(112, 63, 65, '2023-04-08', '0'),
(113, 63, 64, '2023-04-08', '0');

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
(259, 63, 63, '2023-04-09'),
(260, 63, 64, '2023-04-09');

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
(220, 63, 65, '2023-04-10 09:06:28', 'Boooooo', '0');

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
(58, NULL, 64, 63);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `niche`
--
ALTER TABLE `niche`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `niche_membership`
--
ALTER TABLE `niche_membership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `post_comment`
--
ALTER TABLE `post_comment`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `post_comment_reply`
--
ALTER TABLE `post_comment_reply`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post_followership`
--
ALTER TABLE `post_followership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=390;

--
-- AUTO_INCREMENT for table `post_image`
--
ALTER TABLE `post_image`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `post_video`
--
ALTER TABLE `post_video`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `user_blacklist`
--
ALTER TABLE `user_blacklist`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_connection`
--
ALTER TABLE `user_connection`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `user_likeness`
--
ALTER TABLE `user_likeness`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `user_msg`
--
ALTER TABLE `user_msg`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT for table `user_network`
--
ALTER TABLE `user_network`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

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
