USE vk;

SHOW TABLES;
SELECT * FROM likes;
SELECT user_id FROM likes GROUP BY user_id;
SELECT * FROM profiles;

SELECT user_id as uid, 
	cou, 
	(SELECT sex FROM profiles WHERE profiles.user_id = uid) as sex
FROM 
(SELECT user_id, COUNT(*) as cou FROM likes GROUP BY user_id) AS subtub1;

-- кто на первой строке те и ставили большей лайков 

SELECT 
	CASE (sex)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'women'
	END AS sex,
	SUM(cou) FROM (
	SELECT user_id as uid, 
		cou, 
		(SELECT sex FROM profiles WHERE profiles.user_id = uid) as sex
	FROM 
	(SELECT user_id, COUNT(*) as cou FROM likes GROUP BY user_id) AS subtub1
	) as subtab2 GROUP BY sex LIMIT 1;

