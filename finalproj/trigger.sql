USE university;

-- trigger � ������� ��� �������� ��������� � ��� ����, ��� ���� � ������������ 

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	first_name VARCHAR(255),
	second_name VARCHAR(255),
	updated_at DATETIME,
	id INT UNSIGNED
) ENGINE = Archive;

DELIMITER /
DROP TRIGGER IF EXISTS log_persons_update /
CREATE TRIGGER log_persons_udpate AFTER UPDATE ON persons
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (OLD.first_name, OLD.last_name, NOW(), OLD.id);
END/

DELIMITER ;