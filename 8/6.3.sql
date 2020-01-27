USE vk;

SELECT COUNT(*) FROM (SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10) AS subtab
	JOIN likes
		ON likes.target_id = subtab.user_id
			WHERE likes.target_type_id = 2;