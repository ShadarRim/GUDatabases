DROP DATABASE IF EXISTS hw5;
CREATE DATABASE hw5;
USE hw5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	created_at VARCHAR(250),
	updated_at VARCHAR(250)
);

INSERT INTO `users` VALUES ('1','16.02.2020 03:11','17.02.2020 02:11'),
('2','26.02.2020 02:12','20.01.2017 13:39');

-- ('3','1989-01-27 12:18:40','1992-11-26 19:22:12')

UPDATE users SET created_at = ( CONCAT(SUBSTRING(created_at,7,4),
'-',
SUBSTRING(created_at,4,2),
'-',
SUBSTRING(created_at,1,2),
' ',
SUBSTRING(created_at,12,2),
':',
SUBSTRING(created_at,15,2),
':00'));

UPDATE users SET updated_at = ( CONCAT(SUBSTRING(updated_at,7,4),
'-',
SUBSTRING(updated_at,4,2),
'-',
SUBSTRING(updated_at,1,2),
' ',
SUBSTRING(updated_at,12,2),
':',
SUBSTRING(updated_at,15,2),
':00'));


UPDATE users SET created_at = CONVERT(created_at, DATETIME);
ALTER TABLE users MODIFY COLUMN created_at DATETIME;

UPDATE users SET updated_at = CONVERT(updated_at, DATETIME);
ALTER TABLE users MODIFY COLUMN updated_at DATETIME;

SELECT * FROM users;
DESC users;


