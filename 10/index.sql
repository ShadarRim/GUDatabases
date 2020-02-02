USE vk;

#часто отсеиваем по возрасту
CREATE INDEX birthday_prodiles_idx ON profiles(birthday) ;

#наверное, если объем хранимыъ файлов ограничен, то надо легко искать наиболее тяжелые
CREATE INDEX size_media_idx ON media(size);

#встречи часто ищут по имени
CREATE INDEX name_meetings_idx ON meetings(name);

#аналогично для сообществ 
CREATE INDEX name_communities_idx ON communities(name);

#и поиска по фамилии
CREATE INDEX users_last_name_idx ON users(last_name);
