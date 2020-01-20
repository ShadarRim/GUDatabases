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


-- финальный запрос
SELECT SUM(tab2.likes_count) FROM
	(SELECT subtab.target_id, subtab.bd, COUNT(*) as likes_count FROM
		(SELECT id, target_id, (SELECT birthday FROM profiles WHERE profiles.user_id = target_id) as bd FROM likes) AS subtab
	GROUP BY subtab.target_id
	ORDER BY subtab.bd DESC
	LIMIT 10) as tab2
;