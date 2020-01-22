USE vk;

SHOW TABLES;

-- активность для меня - сумма количества поставленный лайков, отправленных сообщений и размещенных медиа материалов (список можно при желании продолжить)
-- в принципе можно приписать коэффиеинты к каждому подсчёту и будет взвешенная сумма

SELECT user_id, SUM(num) as sumnum FROM (
	SELECT id as user_id, 0 as num from users
	UNION
	SELECT user_id, COUNT(*) as num FROM likes GROUP BY user_id
	UNION
	SELECT from_user_id as user_id, COUNT(*) as num FROM messages GROUP BY from_user_id
	UNION
	SELECT user_id, COUNT(*) as num FROM media GROUP BY user_id) AS subtub
GROUP BY user_id
ORDER BY sumnum
LIMIT 10;
