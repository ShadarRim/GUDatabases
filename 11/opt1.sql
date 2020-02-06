USE HW7DB;

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	table_name VARCHAR(15),
	updated_at DATETIME,
	id_note INT UNSIGNED,
	name_note VARCHAR(255)
) ENGINE = Archive;

DELIMITER /
DROP TRIGGER IF EXISTS log_users_insert /
CREATE TRIGGER log_users_insert AFTER INSERT ON users 
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES ('users', NOW(), NEW.id, NEW.name);
END/

DELIMITER ;

DELIMITER /
DROP TRIGGER IF EXISTS log_catalogs_insert /
CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs 
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES ('users', NOW(), NEW.id, NEW.name);
END/

DELIMITER ;

DELIMITER /
DROP TRIGGER IF EXISTS log_products_insert /
CREATE TRIGGER log_products_insert AFTER INSERT ON products 
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES ('users', NOW(), NEW.id, NEW.name);
END/

DELIMITER ;

