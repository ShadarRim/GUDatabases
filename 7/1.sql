use HW7DB;

SHOW TABLES;

SELECT * FROM users;
SELECT * FROM orders;

SELECT * FROM users WHERE
	users.id IN (
	SELECT DISTINCT user_id FROM orders);

-- join запрос

SELECT DISTINCT user_id, users.name, users.birthday_at FROM orders 
JOIN users
ON users.id = orders.user_id;