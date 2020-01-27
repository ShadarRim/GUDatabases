USE vk;

SELECT sex, COUNT(sex) as count_s FROM likes
		JOIN profiles
			ON likes.user_id = profiles.user_id
				GROUP BY sex
					ORDER BY count_s DESC
						LIMIT 1;