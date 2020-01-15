DROP DATABASE IF EXISTS hw5;
CREATE DATABASE hw5;
USE hw5;

DROP TABLE IF EXISTS storehouse_products; 
CREATE TABLE storehouse_products (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	val INT UNSIGNED
);

INSERT INTO `storehouse_products` VALUES ('1','9'),
('2','4'),
('3','1'),
('4','10'),
('5','6'),
('6','4'),
('7','0'),
('8','10'),
('9','8'),
('10','9'),
('11','5'),
('12','7'),
('13','10'),
('14','1'),
('15','10'),
('16','9'),
('17','8'),
('18','10'),
('19','1'),
('20','5'); 

SELECT * FROM storehouse_products ORDER BY val DESC;