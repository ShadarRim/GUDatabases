DROP DATABASE IF EXISTS hw5;
CREATE DATABASE hw5;
USE hw5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	birthday VARCHAR(25)
);

INSERT INTO `users` VALUES ('1','may'),
('2','august'),
('3','october'),
('4','may'),
('5','september');

SELECT * FROM users WHERE birthday IN ('may','october');