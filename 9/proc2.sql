USE HW9DB;

DELIMITER /

DROP TRIGGER IF EXISTS check_name_description_not_null_insert/
CREATE TRIGGER check_name_description_not_null_insert BEFORE INSERT on products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT cansel';
	END IF;
END/

DROP TRIGGER IF EXISTS check_name_description_not_null_update/
CREATE TRIGGER check_name_description_not_null_update BEFORE UPDATE on products
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL AND NEW.description IS NULL) OR (OLD.name IS NULL AND NEW.description IS NULL) OR (NEW.name IS NULL AND OLD.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE cansel';
	END IF;
END/


DELIMITER ;

SELECT * FROM products;
INSERT INTO products VALUES (9,null,null,null,null,null,null);

UPDATE products
SET
	description = NULL
WHERE
	id = 1;

