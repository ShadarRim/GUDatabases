-- вместо Sample и Shop HW7DB и HW9DB. На момент наачала написания кода - они полностью идентичны.

USE HW7DB;

SHOW TABLES;

SELECT * FROM users;

-- вставим человека с id 7 чтобы перенести

INSERT INTO users VALUES (7, 'Тестовый пользователь', NOW(), NOW(), NOW());

START TRANSACTION;

	INSERT INTO HW9DB.users SELECT * FROM HW7DB.users WHERE id = 7;

COMMIT;
