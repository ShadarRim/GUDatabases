USE vk;


SELECT DISTINCT name,
		AVG(COUNT(*) OVER w) as 'Avg',
		COUNT(*) OVER w AS 'Cou',
		MIN(profiles.birthday) OVER w AS 'min_b',
		MAX(profiles.birthday) OVER w AS 'max_b',
		COUNT(*) OVER () AS 'all_users',
		COUNT(*) OVER w / COUNT(*) OVER () as '%%'
	FROM communities
		JOIN communities_users
			ON communities_users.community_id = communities.id
		JOIN profiles
			ON communities_users.user_id = profiles.user_id
		WINDOW w AS (PARTITION BY communities.id);
		