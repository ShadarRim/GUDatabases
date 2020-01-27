USE vk;

SELECT uid, SUM(num) as sumnum 
FROM (
		SELECT profiles.user_id as uid, COUNT(profiles.user_id) as num FROM profiles
			JOIN likes
				ON profiles.user_id = likes.user_id
					GROUP BY uid
	UNION ALL 
		SELECT profiles.user_id as uid, COUNT(profiles.user_id) as num FROM profiles
			JOIN messages
				ON profiles.user_id = messages.from_user_id
					GROUP BY uid ) AS subtab
GROUP BY uid
ORDER BY sumnum
LIMIT 10;