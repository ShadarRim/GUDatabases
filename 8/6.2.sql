USE vk;

SELECT friendship.friend_id, COUNT(*) FROM friendship
	LEFT JOIN messages
		ON messages.to_user_id = friendship.user_id AND friendship.friend_id = messages.from_user_id
WHERE friendship.user_id = 5 AND friendship.status_id = 2 
GROUP BY friend_id
LIMIT 1;

