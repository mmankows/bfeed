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
    `beacon_id`   char(34) NOT NULL PRIMARY KEY,
    `user_id`     BIGINT NOT NULL,
    `minor_id`    char(34) NOT NULL,
    `major_id`    char(34) NOT NULL,
    `name`        char(255) NOT NULL,
    `description` blob,
    FOREIGN KEY (`user_id`) REFERENCES user (`user_id`)
);

-- Table for storing content assigned to beacons
CREATE TABLE content (
    `content_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `beacon_id`  char(34) NOT NULL,
    `name`       char(255) NOT NULL,
    `desc`       blob NOT NULL,
    `url`        blob NOT NULL,
    `img_url`    blob NOT NULL,
    FOREIGN KEY (`beacon_id`) REFERENCES beacon (`beacon_id`)
);

-- Rules matched to acquire specific content
CREATE TABLE rule (
    `rule_id`    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_id` BIGINT NOT NULL,
    `beacon_id`  char(34) NOT NULL,
    `name`       char(255) NOT NULL,
    `desc`       blob NOT NULL,
    `rule`       blob NOT NULL,
    `type`       ENUM('ALLOW','GET') NOT NULL DEFAULT 'ALLOW',
    FOREIGN KEY (`beacon_id`) REFERENCES beacon (`beacon_id`),
    FOREIGN KEY (`content_id`) REFERENCES content (`content_id`)
);

-- ----------------------------------------------------------------------------
-- ---------------- HELPERS ---------------------------------------------------

-- Table for logging evants
CREATE TABLE beaconlog (
    `beaconlog_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_id` BIGINT NOT NULL,
    `beacon_id`  char(34) NOT NULL,
    `logdate`    TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(),
    FOREIGN KEY (`content_id`) REFERENCES content (`content_id`)
);

