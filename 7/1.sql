use HW7DB;

SHOW TABLES;

SELECT * FROM users;
SELECT * FROM orders;

SELECT * FROM users WHERE
	users.id IN (
	SELECT DISTINCT user_id FROM orders);
	