CREATE TABLE `user`(
    `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `uuid` VARCHAR(28),
    `username` VARCHAR(20) NOT NULL UNIQUE,
    `email` VARCHAR(100),
    `phone_number` VARCHAR(15),
    `password` VARCHAR(225),
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `nationality` VARCHAR(50),
    `work_info` VARCHAR(500),
    `relationship`  CHAR(1),
    `school_info` VARCHAR(500), 
    `dob` date,
    `photo` VARCHAR(128),
    `intro` VARCHAR(225),
    `gender` char(1),
    `hobbies` VARCHAR(128)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `user_connection`(
    `id` int UNSIGNED PRIMARY KEY  AUTO_INCREMENT,
    `sender` int UNSIGNED,
    `receiver` int UNSIGNED,
    `date` date,
    CONSTRAINT `connector` FOREIGN KEY(`sender`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `connectee` FOREIGN KEY(`receiver`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_network`(
    `id` int UNSIGNED PRIMARY KEY  AUTO_INCREMENT,
    `date` date,
    `user1` int UNSIGNED,
    `user2` int UNSIGNED,
    CONSTRAINT `u1` FOREIGN KEY(`user1`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `u2` FOREIGN KEY(`user2`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE `user_msg`(
    `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `sender` int UNSIGNED,
    `receiver` int UNSIGNED,
    `datetime` datetime,
    `body` VARCHAR(1000),
    `read` char(1),
    CONSTRAINT `msg_sender_id` FOREIGN KEY(`sender`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `msg_receiver_id` FOREIGN KEY(`receiver`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_notification`(
    `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `datetime` datetime,
    `description` varchar(255),
    `destination_url` varchar(128)

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `niche`(
    `id` smallint  UNSIGNED PRIMARY KEY  AUTO_INCREMENT,
    `name` VARCHAR(255), 
    `alias` VARCHAR(9),
    `date` date,
    `rank` smallint,
    `parent` smallint UNSIGNED ,
    CONSTRAINT `parent_niche_id` FOREIGN KEY(`parent`) REFERENCES `niche`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION
    
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `niche_membership`(
    `id` int UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
    `member` int UNSIGNED,
    `niche` smallint UNSIGNED,
    `date` date,
    CONSTRAINT `niche_member_id` FOREIGN KEY(`member`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `said_niche_id` FOREIGN KEY(`niche`) REFERENCES `niche`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `post`(
    `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `uuid` VARCHAR(128),
    `category` smallint UNSIGNED,
    `poster` int UNSIGNED,
    `type` VARCHAR(25),
    `title`  VARCHAR(128),
    `date_created` datetime,
    `date_updated` datetime,
    `slug` VARCHAR(225),
    `content` text,
    `views` int UNSIGNED,
    CONSTRAINT `niche_posted_in_id` FOREIGN KEY(`category`) REFERENCES `niche`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT `poster_id` FOREIGN KEY(`poster`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
    
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `post_image`(
    `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `post` int UNSIGNED,
    `path` VARCHAR(128),
        CONSTRAINT `posted_in` FOREIGN KEY(`post`) REFERENCES `post`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 
 
CREATE TABLE `post_followership`(
    `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `post` int UNSIGNED,
    `follower` int UNSIGNED,
    `date`  date,
    CONSTRAINT `post_followed` FOREIGN KEY(`post`) REFERENCES `post`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `post_follower` FOREIGN KEY(`follower`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `post_comment`(
    `id` smallint UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `uuid` VARCHAR(128),
    `commenter` int UNSIGNED,
    `date_created` datetime,
    `date_updted`  datetime,
    `post` int UNSIGNED,
    `content` varchar(1000),
    CONSTRAINT `commenter_id` FOREIGN KEY(`commenter`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT `post_commented_id` FOREIGN KEY(`post`) REFERENCES `post`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `post_comment_reply`(
    `id` smallint UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `comment` smallint UNSIGNED,
    `replyer` int  UNSIGNED,
    `date` date,
    `content`  varchar(500),
    CONSTRAINT `comment_replied_id` FOREIGN KEY(`comment`) REFERENCES `post_comment`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `replyer_id` FOREIGN KEY(`replyer`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



