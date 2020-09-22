CREATE DATABASE testdb;
CREATE DATABASE users;
USE users;

DROP TABLE IF NOT EXISTS `users`;

CREATE TABLE `users` (
  `userName` VARCHAR(30) NOT NULL
);

INSERT INTO `users` VALUES ('Bob'),('Jay'),('Matt'),('Ferg'),('Mo');
