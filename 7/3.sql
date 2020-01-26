DROP DATABASE IF EXISTS HW7DB2;
CREATE DATABASE HW7DB2;

use HW7DB2;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL,
	from_c VARCHAR(40),
	to_c VARCHAR(40)
);

INSERT INTO flights VALUES
(1, 'moscow', 'omsk'),
(2, 'novgorod', 'kazan'),
(3, 'irkutsk', 'moscow'),
(4, 'omsk', 'irkutsk'),
(5, 'moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(40),
	name VARCHAR(40)
);

INSERT INTO cities VALUES
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('omsk', 'Омск'),
('novgorod', 'Новгород'),
('kazan', 'Казань');

SELECT id,
	(SELECT name FROM cities WHERE label = flights.from_c) as from_c,
	(SELECT name FROM cities WHERE label = flights.to_c) as to_c
FROM
	flights;

-- через Join

SELECT subtub.id, subtub.from_n, cities.name FROM
(SELECT id, cities.name as from_n, to_c FROM flights
JOIN cities
ON cities.label = flights.from_c) AS subtub
JOIN cities
ON cities.label = subtub.to_c;