USE HW9DB;

DELIMITER /

DROP FUNCTION IF EXISTS fib/
CREATE FUNCTION fib(n INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE one INT;
	DECLARE two INT;
	DECLARE three INT;
	DECLARE i INT;
	SET one = 0;
	SET two = 1;
	SET i = n - 1;
	IF n = 0 THEN
		RETURN 0;
	ELSEIF n = 1 THEN
		RETURN 1;
	ELSE
		WHILE i > 0 DO
			SET three = one + two;
			SET one = two;
			SET two = three;
			SET i = i - 1;
		END WHILE;
		RETURN two;
	END IF;
END/

SELECT fib(1)/