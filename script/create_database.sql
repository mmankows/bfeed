DROP DATABASE IF EXISTS `bfeed_data`;
CREATE DATABASE `bfeed_data`;
USE `bfeed_data`;

-- ----------------------------------------------------------------------------
-- ---------------- MAIN BUSSINESS LOGIC --------------------------------------

-- Authenticaton
CREATE TABLE user (
    `user_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `login`   char(32) NOT NULL,    
    `pass`    char(32) NOT NULL,
    `email`   char(64) NOT NULL,
    `role`    ENUM('STANDARD','ADMIN')
);

-- Table for keeping beacons information
CREATE TABLE beacon (
    `beacon_id`	  BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`     BIGINT NOT NULL,
    `short_id`    char(34) NOT NULL,

    `uu_id`       char(36) NOT NULL,
    `minor_id`    char(36) NOT NULL,
    `major_id`    char(36) NOT NULL,

    `name`        char(255) NOT NULL,
    `description` text,
    FOREIGN KEY (`user_id`) REFERENCES user (`user_id`)
);

-- Table for storing content assigned to beacons
CREATE TABLE content (
    `content_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`     BIGINT NOT NULL,
    `name`       char(255) NOT NULL,
    `description`       text NOT NULL DEFAULT '',
    `url`        text NOT NULL DEFAULT '',
    `img_url`    text NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES user (`user_id`)
);

-- Rules matched to acquire specific content
CREATE TABLE rule (
    `rule_id`    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`     BIGINT NOT NULL,
    `content_id` BIGINT NOT NULL,
    `beacon_id`  BIGINT NOT NULL,
    `name`       char(255) NOT NULL,
    `description`       text NOT NULL,
    `rule`       text NOT NULL,
    FOREIGN KEY (`beacon_id`) REFERENCES beacon (`beacon_id`),
    FOREIGN KEY (`content_id`) REFERENCES content (`content_id`),
    FOREIGN KEY (`user_id`) REFERENCES user (`user_id`)
);

-- ----------------------------------------------------------------------------
-- ---------------- HELPERS ---------------------------------------------------

-- Table for logging evants
CREATE TABLE beaconlog (
    `beaconlog_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_id` BIGINT NOT NULL,
    `beacon_id`  BIGINT NOT NULL,
    `logdate`    TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
);

