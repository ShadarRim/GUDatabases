USE vk;

SHOW TABLES;

-- добавление данных для теста: иначе нет сообщений от пользователей-друзей

INSERT INTO messages VALUES 
('1001','44','5','text','1','1',NOW()),
('1002','44','5','text1','1','1',NOW()),
('1003','44','5','text2','1','1',NOW()),
('1004','69','5','text','1','1',NOW()),
('1005','69','5','text','1','1',NOW());

-- основной запрос
SELECT from_user_id,
COUNT(*) as count_data 
FROM messages 
WHERE to_user_id=5 AND
from_user_id IN (
	SELECT friend_id FROM friendship WHERE (user_id=to_user_id AND status_id=2))
GROUP BY from_user_id 
ORDER BY count_data DESC 
LIMIT 1;


-- вспомогательый код для отладки

DESC messages;
DESC friendship;
DESC friendship_statuses;

SELECT * FROM friendship_statuses fs;

-- conf == 2

SELECT * from friendship WHERE status_id = 2 LIMIT 20;

SELECT friend_id FROM friendship WHERE (user_id=5 AND status_id=2);


SELECT * FROM messages WHERE to_user_id = 5;

