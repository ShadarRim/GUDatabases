-- ������ Sample � Shop HW7DB � HW9DB. �� ������ ������� ��������� ���� - ��� ��������� ���������.

USE HW7DB;

SHOW TABLES;

SELECT * FROM users;

-- ������� �������� � id 7 ����� ���������

INSERT INTO users VALUES (7, '�������� ������������', NOW(), NOW(), NOW());

START TRANSACTION;

	INSERT INTO HW9DB.users SELECT * FROM HW7DB.users WHERE id = 7;

COMMIT;
