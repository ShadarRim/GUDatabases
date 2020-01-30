USE HW9DB;

DELIMITER /

DROP FUNCTION IF EXISTS hello/
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE h INT;
	SET h = DATE_FORMAT(NOW(), '%H');
	CASE
		WHEN h >= 6 and h < 12 THEN RETURN 'Доброе утро!';
		WHEN h >= 12 and h < 18 THEN RETURN 'Добрый день!';	
		WHEN h >= 18 and h < 24 THEN RETURN 'Добрый вечер!';
		WHEN h >= 0 and h < 6 THEN RETURN 'Доброй ночи!';
	END CASE;
END/

SELECT hello()/