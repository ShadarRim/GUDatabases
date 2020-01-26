USE vk;

SHOW TABLES;
SELECT * FROM likes;
SELECT * FROM profiles;
-- users - id 2
SELECT * FROM target_types;

-- этот запрос возвращает топ 10 самых молодых пользователей

SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;

-- а этот считает лайки пользователя

SELECT target_id, COUNT(*) as count_likes FROM likes WHERE target_type_id = 2 GROUP BY target_id;

-- а вместе их не соеденить потому, что в WHERE нельзя добавить подзапрос с LIMIT

-- придумал!
SELECT target_id as target, COUNT(*) as count_likes FROM likes WHERE target_type_id = 2 GROUP BY target_id;


-- финальный запрос №1
SELECT SUM(tab2.likes_count) FROM
	(SELECT subtab.target_id, subtab.bd, COUNT(*) as likes_count FROM
		(SELECT id, target_id, (SELECT birthday FROM profiles WHERE profiles.user_id = target_id) as bd FROM likes WHERE target_type_id = 2) AS subtab
	GROUP BY subtab.target_id
	ORDER BY subtab.bd DESC
	LIMIT 10) as tab2
;

-- ещё вариант №2
SELECT SUM(count_likes) FROM (
	SELECT target_id, COUNT(*) as count_likes FROM likes WHERE target_type_id = 2 AND target_id IN
	(SELECT * FROM
		(SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) as tab)
	GROUP BY target_id) AS fintab;

-- обратите внимание, что ответы не сходятся
-- всё дело в том, что первый запрос считает лайки, у пользователей, а затем сортирует по возрасту
-- второй же запрос сначала находит топ-10 по возрасту, потому считает их лайки (точнее оставляет)
-- в итоге по второму запросу есть пользователи, который не в топ-10 попали, но лайков не получили
-- а в первом запросе топ-10 из тех кто получил лайки




