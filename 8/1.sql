USE vk;

DESC profiles;

ALTER TABLE profiles MODIFY photo_id INT UNSIGNED;

ALTER TABLE profiles
	ADD CONSTRAINT profiles_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT profiles_photo_id_fk
		FOREIGN KEY (photo_id) REFERENCES media(id)
			ON DELETE SET NULL;
			
DESC messages;

ALTER TABLE messages
	ADD CONSTRAINT messages_from_user_id_fk
		FOREIGN KEY (from_user_id) REFERENCES users(id),
	ADD CONSTRAINT messages_to_user_id_fk
		FOREIGN KEY (to_user_id) REFERENCES users(id);

-- удаление не приводит к простановки null, ведь media_type - словарь, из него типы удаляться не должны по логике	
	
ALTER TABLE media
	ADD CONSTRAINT media_media_type_id_fk
		FOREIGN	KEY (media_type_id) REFERENCES media_types(id);
	
-- исчезло событие - исчезли связи, удаление пользователя отсавляет его в таблице, чтобы сохранялась история
-- для такого состояния в vk вводят статус "пользователь удалён", но сейчас я дополнительного этого делать не буду
		
ALTER TABLE communities_users
	ADD CONSTRAINT communities_users_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT communities_users__user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
		
DESC posts;

ALTER TABLE posts MODIFY media_id INT UNSIGNED;

ALTER TABLE posts
	ADD CONSTRAINT posts_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT posts_media_id_fk
		FOREIGN KEY (media_id) REFERENCES media(id)
			ON DELETE SET NULL;

ALTER TABLE meetings
	ADD CONSTRAINT meetings_creator_id_fk
		FOREIGN KEY (creator_id) REFERENCES users(id);
		
ALTER TABLE meetings_users
	ADD CONSTRAINT meetings_users_meeting_id_fk
		FOREIGN KEY (meeting_id) REFERENCES meetings(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT meetings_users_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
		
ALTER TABLE friendship
	ADD CONSTRAINT friendship_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT friendship_freind_id_fk
		FOREIGN KEY (friend_id) REFERENCES users(id);

ALTER TABLE friendship
	ADD CONSTRAINT friendship_status_id_fk
		FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
		
ALTER TABLE likes
	ADD CONSTRAINT likes_used_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT likes_target_type_id_fk
		FOREIGN KEY (target_type_id) REFERENCES target_types(id);