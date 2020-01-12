USE vk;
SHOW TABLES;

-- media_types
SELECT * FROM media_types;

TRUNCATE media_types;
INSERT INTO media_types (name) VALUES
	('photo'),
	('video'),
	('audio');

-- media
UPDATE media SET	
	media_type_id = FLOOR(1+ (RAND()*3)),
	user_id = FLOOR(1 + (RAND() *100));
UPDATE media SET metadata = CONCAT(
	'{"', 'owner', '":"',
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
	'"}');
ALTER TABLE media MODIFY COLUMN metadata JSON;
UPDATE media SET filename = CONCAT('http://dropbox/vk/file_', size);
SELECT * FROM media;
DESC media;

-- profiles
SELECT * FROM profiles LIMIT 10;
-- photo_id должно включать в себя только медиа типа photo
UPDATE profiles SET photo_id = (
SELECT id FROM media WHERE media.media_type_id = 
(SELECT id FROM media_types WHERE name = 'photo')
ORDER BY RAND() 
LIMIT 1
);

-- users
SELECT * FROM users LIMIT 10;

-- messages
-- удалю столбец media_id так как не понимаю как сделать в нём случайные значения либо пусто либо id
SELECT * FROM messages LIMIT 10;
ALTER TABLE messages DROP COLUMN media_id;

-- friend
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES
	('req'),
	('conf'),
	('reject');
UPDATE friendship SET	
	status_id = FLOOR(1+ (RAND()*2));
	
-- communities and com_users
DELETE FROM communities WHERE id > 20;
UPDATE communities_users SET
	user_id = FLOOR(1 + (RAND() *100)),
	community_id = FLOOR(1 + (RAND() *20));
-- изменяем photo_id
UPDATE communities SET photo_id = (
SELECT id FROM media WHERE media.media_type_id = 
(SELECT id FROM media_types WHERE name = 'photo')
ORDER BY RAND() 
LIMIT 1a
);

SELECT * FROM communities;
SELECT * FROM communities_users;

-- исправления по итогам предложений
CREATE TABLE posts (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    headet VARCHAR(255),
    body TEXT NOT NULL,
    media_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
SELECT * FROM posts LIMIT 10;

DROP TABLE meetings;
CREATE TABLE meetings (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
-- id создателя
    creator_id INT UNSIGNED NOT NULL,
    scheduled_at DATETIME 
);

SELECT * FROM meetings LIMIT 10;

-- нужно добавить таблицу связывающую meetings и пользователей, которые хотят идти
CREATE TABLE meetings_users (
	meeting_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
    submited_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`,`meeting_id`)
);

-- вставляем данные

INSERT INTO `meetings_users` VALUES ('6','26','1987-11-12 14:21:57'),
('3','28','1985-07-12 07:47:00'),
('12','29','1974-11-04 03:46:19'),
('1','34','1975-11-03 21:05:41'),
('9','35','2015-11-08 03:09:34'),
('18','37','2013-07-02 00:39:35'),
('20','38','1991-08-08 02:55:26'),
('16','39','2010-07-28 09:45:59'),
('15','43','2015-02-02 11:42:01'),
('10','47','2005-01-09 05:00:01'),
('19','60','2018-04-19 03:03:55'),
('17','70','2007-09-21 15:24:35'),
('14','71','2004-06-14 06:27:26'),
('8','75','2017-07-25 09:14:21'),
('11','77','1993-03-15 21:22:20'),
('7','81','1984-05-20 13:14:07'),
('2','85','1982-10-29 02:27:09'),
('4','88','2019-06-01 13:06:57'),
('13','91','1980-06-29 12:56:12'),
('14','2','1980-07-29 03:42:12'),
('15','1','1981-06-29 01:56:13'),
('19','4','1980-06-29 12:56:12'),
('13','16','1980-06-29 12:56:12'),
('5','97','2016-06-04 05:57:08'); 


INSERT INTO `meetings` VALUES ('1','repudiandae','71','1990-12-15 15:57:02'),
('2','similique','56','2019-01-26 13:11:17'),
('3','esse','20','1983-06-12 01:58:05'),
('4','reiciendis','35','2007-12-21 05:20:22'),
('5','deleniti','71','1976-07-16 05:27:41'),
('6','qui','91','1970-09-15 20:06:34'),
('7','ut','60','2002-07-16 11:21:32'),
('8','sit','63','1970-01-30 01:37:44'),
('9','possimus','23','1992-11-12 04:09:16'),
('10','quos','32','1986-02-15 05:03:48'),
('11','accusamus','87','2018-11-23 18:35:04'),
('12','aut','50','1996-04-30 02:39:55'),
('13','quod','34','2017-05-23 03:15:44'),
('14','sunt','1','2015-08-04 10:56:35'),
('15','impedit','54','1976-05-14 11:11:48'),
('16','unde','85','1995-03-19 02:58:28'),
('17','est','85','1989-12-14 04:52:09'),
('18','omnis','37','1970-01-29 11:17:35'),
('19','officia','51','2004-07-05 13:18:20'),
('20','exercitationem','15','2019-01-27 03:54:01'); 

INSERT INTO `posts` VALUES ('1','100','aut','Beatae quae harum saepe quia tempora alias. Veritatis labore pariatur voluptas enim alias deserunt sed quia. Iure quaerat ad ipsum autem repellat esse saepe. Saepe natus vel et iste.','1','1999-03-02 23:18:36','1995-09-28 23:39:27'),
('2','30','minus','Qui corporis quaerat asperiores debitis qui vel. Distinctio velit placeat voluptate similique nihil architecto harum. Quis delectus ad rerum architecto voluptates qui. Ipsa labore fugiat veritatis facere.','1','1972-08-11 01:28:26','2013-10-01 04:27:46'),
('3','98','est','Facere eos aliquam quia voluptatibus expedita. Non architecto quasi quasi quas distinctio. Et libero temporibus ex est aut unde.','3','2006-09-28 12:05:17','2005-04-14 10:10:51'),
('4','5','illo','Minus quam odio voluptate ipsam et quidem. Aliquam illo ea recusandae perspiciatis saepe neque.','1','1983-01-07 05:33:19','2010-11-16 16:46:32'),
('5','81','qui','Quo quae odio dolorum est aut. Aspernatur aliquid est doloremque amet. Qui ut culpa ut et suscipit. Officiis sequi ut omnis aut.','2','2010-05-26 20:50:07','1972-06-13 22:42:10'),
('6','10','laudantium','Voluptatem tenetur itaque aliquid veniam ratione. Et ea dolore deleniti rem debitis ipsa ut.','2','1997-03-02 20:46:00','2019-07-24 10:57:59'),
('7','3','incidunt','Doloremque sed doloribus blanditiis itaque similique ex consequatur. Quis incidunt aliquid odio. Reiciendis tempora est ab aut autem fuga.','2','1977-02-06 10:43:03','2008-08-26 11:42:33'),
('8','58','enim','Voluptate eos quisquam sint distinctio. Laudantium et velit reiciendis cum velit. Ipsum vero repudiandae aliquam repellendus in. Dolorem nobis magnam consectetur pariatur esse.','1','1976-06-03 21:34:43','1972-07-22 12:14:29'),
('9','79','perferendis','Qui occaecati et architecto iusto. Nobis occaecati quam est molestiae quis voluptatem. Aut necessitatibus quis rem illum. Velit et et quidem magnam eveniet facere minima est.','2','2015-06-05 00:26:42','2019-12-15 10:27:06'),
('10','22','asperiores','Qui esse omnis ratione fugit. Error non est eum ad delectus quam. Id fuga natus magni blanditiis autem iure voluptatum.','3','1971-02-23 12:52:30','1995-08-27 10:59:59'),
('11','4','explicabo','Nostrum repudiandae voluptas necessitatibus sed earum quasi alias. Dolor ut debitis nostrum minus reprehenderit doloremque. Omnis voluptatibus labore qui aut eum ut. Dolores nesciunt explicabo alias nihil perferendis odio.','2','1979-02-08 03:36:41','1987-07-02 00:03:07'),
('12','86','eum','Sapiente aut quas nihil quisquam commodi quae officia. Commodi velit libero corporis et at sed ea fugiat. Exercitationem necessitatibus non vel ratione laboriosam corporis vel.','2','2013-10-24 14:51:08','1996-03-27 09:43:52'),
('13','87','animi','Autem maxime dolores molestiae voluptatem iusto voluptas rem. Quia qui quam exercitationem esse. Sit velit expedita provident exercitationem. Omnis mollitia tenetur placeat rem earum aspernatur velit.','2','1996-07-09 02:25:38','1976-06-15 23:59:10'),
('14','70','adipisci','Facilis natus rerum aut et. Molestias ea quia delectus voluptas voluptatem qui. Voluptatem sit et tenetur qui quo in. Sed qui sapiente sequi quam unde sed. Repellat ut numquam soluta enim.','1','1975-09-20 20:02:45','1983-11-02 03:19:59'),
('15','23','dolores','Qui sit sapiente et voluptatem. Quia et nulla similique id sit illum. Qui voluptates a cupiditate animi sed. Aut rerum aut molestiae id totam.','1','1985-05-31 21:56:57','2007-12-16 19:51:39'),
('16','64','harum','Qui provident asperiores corporis quibusdam dolor sint fugit. Odio temporibus dolorum et nulla omnis ut culpa. Vel accusantium rerum sint hic natus harum. Tempore non corporis distinctio rem ullam.','2','1978-02-22 20:46:52','2007-03-20 09:27:20'),
('17','3','perspiciatis','Iusto provident incidunt recusandae. Est id id animi et culpa ea. Incidunt maxime et omnis quia voluptate sit.','1','1988-02-01 14:18:38','1993-05-29 21:10:13'),
('18','20','accusamus','Deleniti veritatis dolore est ut deleniti. Eligendi eveniet sed necessitatibus labore est nam. Libero officia soluta a sequi. Illo aut numquam tenetur voluptates. Qui at et inventore repellendus animi rem vel ratione.','3','1994-07-30 05:52:50','2018-08-22 04:53:55'),
('19','40','qui','Qui voluptatem recusandae saepe mollitia nam dicta. Sed ipsa amet aspernatur sed error. Temporibus atque facere amet voluptate sed magnam corrupti.','2','1996-01-03 14:11:29','2001-06-14 11:58:18'),
('20','71','est','Eos cumque architecto enim sint aut quas. Est recusandae qui delectus sit eveniet et voluptatem nihil. Deserunt consequatur nisi ratione commodi aut dolor.','2','2015-05-22 08:20:50','1992-12-06 15:01:15'),
('21','21','eum','Ipsam omnis dignissimos tempore laborum praesentium cupiditate. Consectetur ratione harum eaque deserunt rerum.','2','1973-09-21 23:58:04','1971-05-01 15:49:15'),
('22','5','delectus','Nihil tempora numquam voluptate officiis numquam. Consectetur et sequi est necessitatibus ullam. Quos aut nemo exercitationem magni hic quas reprehenderit iure. Incidunt consequatur aut officiis facilis quis voluptatem in.','2','1984-01-23 09:43:08','2006-08-20 17:55:25'),
('23','17','voluptate','Aut recusandae eos qui ab quam vero. Illum harum aut id rerum. Sed repudiandae inventore libero officia dolorum. Ad magnam tenetur recusandae sapiente harum fugiat.','3','1970-10-10 00:56:27','1979-03-31 06:59:13'),
('24','100','tempora','Dolor soluta fugit delectus quia sunt quis. Aut velit maxime necessitatibus suscipit qui quibusdam. Et veniam blanditiis neque voluptates aut voluptas laudantium. Quas vitae dignissimos incidunt ex.','2','2004-02-13 06:53:55','2013-06-09 09:27:03'),
('25','47','quia','Est et autem non non. Itaque voluptas neque impedit neque consequuntur hic omnis ullam. Laudantium facere sed error vero quis.','3','1975-06-12 21:15:01','1978-08-09 11:29:45'),
('26','50','dolorem','Dolor iste voluptatem quam saepe doloremque. Labore quisquam cum aspernatur eos ut quas non. Dolorem quo eligendi maxime ut. Ut ipsam non corporis ipsam nobis dolore.','2','1996-01-11 17:38:00','1997-05-14 19:02:11'),
('27','5','officia','Consequatur deserunt iusto reiciendis. Laboriosam et quibusdam qui asperiores aspernatur est eos. Delectus eius nobis quibusdam et non. Porro et ut qui porro.','2','1975-03-02 07:16:45','1977-07-12 02:01:42'),
('28','76','deleniti','Numquam quas qui ad vel autem quae magnam omnis. Et voluptatibus dolorem necessitatibus ab. Dignissimos aliquam qui aspernatur cum a. Error cumque voluptate maxime incidunt numquam debitis.','1','2006-12-16 18:37:20','2000-03-06 07:18:38'),
('29','5','aut','Amet necessitatibus voluptas modi totam similique omnis neque. Molestiae et ex et aut. Fuga quod qui natus optio sed. Modi saepe iure voluptates illo qui nam omnis.','2','1979-01-03 15:45:41','1981-02-27 11:14:21'),
('30','37','ut','Ea dolores laboriosam perferendis. Quaerat maiores asperiores suscipit et est ipsa esse. Unde fugit cupiditate repellat. Id iusto ipsam occaecati sit atque.','1','2010-11-05 07:58:26','2016-04-20 19:28:41'),
('31','69','aspernatur','Minus et qui suscipit fugit eaque. Tempora deserunt sit impedit. Eaque ipsa aperiam iure.','2','2014-07-01 03:27:59','1993-04-23 01:47:01'),
('32','87','dignissimos','Rerum quam qui dolorem quas qui. Culpa ut possimus est expedita aspernatur. Omnis numquam voluptatem quod aliquam. Consectetur dolorem fugiat eaque quas soluta illo.','1','2019-01-28 11:44:20','1998-04-05 18:48:25'),
('33','7','at','Quia culpa nam explicabo quibusdam enim. Veniam et corrupti ut quia natus. Omnis expedita quo rerum. Ex debitis deserunt alias quibusdam est unde.','3','1990-03-20 13:46:29','2007-08-22 23:44:59'),
('34','55','aut','Aut perspiciatis a omnis quas consequuntur optio ut. Dolorum error eos sint voluptatem sequi architecto numquam.','1','1988-08-12 03:59:26','2012-05-03 18:59:33'),
('35','69','eaque','Quos veritatis tempora doloribus et. Earum deleniti odit ut cumque numquam error quam. Nihil officiis quo eos officia consequatur recusandae culpa. Quae dolor doloremque rerum deleniti unde.','3','1994-01-06 18:02:40','1985-11-12 20:37:17'),
('36','70','sint','Omnis aut laboriosam adipisci quam non at quo. Sequi qui eos illo sed officia. Asperiores quia deleniti et et. Distinctio maxime autem quidem eos ad et aspernatur.','3','1992-10-03 11:20:56','1982-01-02 13:20:33'),
('37','17','veniam','Eveniet quisquam velit soluta animi hic minus. Qui dolores unde rem ea at occaecati sint. Eius neque exercitationem voluptates iste excepturi ab voluptas.','2','2011-07-19 22:36:23','1978-01-11 02:52:29'),
('38','22','qui','Eveniet asperiores doloribus modi voluptatem et dicta. Sed vel delectus et atque minima aut. Aliquam numquam dolore facere fuga et amet vel. Quidem necessitatibus maxime aut deserunt nam.','3','1971-04-08 12:56:34','1985-05-25 20:36:54'),
('39','1','autem','Quo optio earum maxime tenetur. Totam ad tempora a iste perspiciatis sequi molestiae. Alias aliquam sit iure reiciendis nobis et. Natus veritatis est aut ab.','1','1980-06-08 21:13:39','1994-04-13 19:29:06'),
('40','43','deleniti','Rem doloribus eveniet officiis ea. Ab magni illo similique repellendus excepturi. Qui ipsam tenetur voluptates.','1','1994-12-27 09:04:38','1979-03-24 23:48:04'),
('41','68','sit','Inventore quas aperiam dolor sed voluptatem. Voluptatem et ut nihil. Quis corporis eius velit quia et.','3','2018-11-15 19:18:08','2012-07-23 01:50:00'),
('42','56','cumque','Quia explicabo modi enim. Pariatur sit sequi minima dolores. Quia quia accusantium velit est et. Fugit doloribus ullam cumque provident.','1','1975-12-27 10:18:57','2004-09-26 04:06:09'),
('43','38','sunt','Non impedit inventore id explicabo repudiandae sunt eligendi iure. Eos assumenda est aliquam dolores explicabo. Cupiditate assumenda aperiam ipsam cumque ut quas. Odit id fuga accusamus debitis est.','3','2011-01-22 10:23:26','2000-06-30 04:00:37'),
('44','62','eum','Aspernatur illo quia tenetur et quaerat eligendi sunt. Qui sit necessitatibus et dolor rerum qui suscipit enim. Natus ut et aut ullam.','3','2017-09-09 11:31:36','1980-01-15 04:15:19'),
('45','9','velit','Itaque et fugit at aperiam aut est. Aliquam ut aliquam libero unde labore aut illum. Ut nobis recusandae veritatis modi dolorem.','3','1997-01-26 03:03:05','1994-12-24 02:23:56'),
('46','71','praesentium','Magni et quam qui temporibus ea iste eum. Vel autem id dolor voluptatum aut non.','3','2012-10-24 06:58:36','2002-01-19 03:40:39'),
('47','73','totam','Adipisci id distinctio sit reiciendis. Facere dolore magni pariatur laborum. Nemo occaecati necessitatibus dignissimos quia minus iste temporibus.','3','1975-11-26 14:47:46','1999-11-01 02:34:50'),
('48','73','sed','Ut aut repellat dolorem. Nisi qui deserunt a.','3','1972-12-09 04:12:46','1999-06-01 16:26:47'),
('49','94','dolorem','Ab et non laborum numquam. Ducimus doloremque eos est molestias fugit. Distinctio libero laborum dolorem doloremque tempore enim.','2','1985-11-28 21:00:48','2014-06-22 18:45:45'),
('50','46','dignissimos','Vitae maxime eius aperiam dolor odit architecto. Quis exercitationem et pariatur aspernatur autem blanditiis. Corporis ipsam saepe vero voluptas quae consectetur maiores.','1','2006-10-25 21:47:07','1971-02-20 11:53:12'),
('51','100','fugit','Illum blanditiis voluptas rerum et unde. Omnis omnis assumenda debitis repudiandae. Dolorem modi impedit voluptatem est rem nesciunt. Consequatur debitis qui corporis tempore voluptatum corporis similique. Quia est consectetur asperiores.','1','2007-05-07 22:00:30','2017-12-26 13:10:27'),
('52','19','doloribus','Reprehenderit illo qui ut et exercitationem eum. Vel provident et qui et mollitia corporis nesciunt. Et rem rem repudiandae quasi.','1','1989-03-03 15:59:22','2010-03-12 17:58:47'),
('53','75','culpa','Enim ad eum iste maiores tempore impedit. Nam voluptatem deleniti qui repudiandae. Eaque inventore quia consequatur placeat vitae. Voluptate error ratione et dicta doloribus neque commodi.','1','2017-11-06 08:34:41','1993-07-19 19:41:42'),
('54','80','eveniet','Est quia quos nulla libero similique quam. Saepe consequatur cum reiciendis id.','2','2010-01-26 07:35:45','1985-10-22 21:19:24'),
('55','59','modi','Nemo odio sed officiis aut. Vero magnam qui aliquid totam sunt. Suscipit maiores et voluptas labore minus inventore. Officia et voluptatem totam fuga corrupti sed laborum.','1','2003-12-08 19:48:43','2004-03-25 12:11:50'),
('56','76','quod','Est excepturi consequatur assumenda nesciunt ea et quas. Fuga facilis id autem. Rerum vel accusantium deleniti laborum officia voluptas. Est aut velit sit sequi nesciunt.','1','2015-07-02 04:19:36','1973-05-04 12:57:45'),
('57','30','ut','Iure qui et est porro quia officia qui atque. Quaerat sint necessitatibus occaecati iure ex. Perspiciatis magnam eveniet quaerat non exercitationem et.','3','2017-01-12 19:38:53','2009-07-18 13:39:59'),
('58','83','vel','Debitis et expedita sint culpa natus quo. Qui impedit officiis possimus perferendis enim.','2','1994-08-24 18:52:50','1989-05-30 05:42:22'),
('59','40','enim','Ad sunt autem sit cumque sed. Nam aut maxime in rem. Eos autem incidunt error eos.','1','1991-03-10 17:48:13','2011-09-27 00:13:53'),
('60','16','dolor','Tenetur ut quasi quod nulla et. Voluptatem harum tenetur vitae et est inventore. Cum cupiditate sed blanditiis omnis. Nulla animi qui aut ab ea voluptas qui. Fugit ut placeat eligendi fugiat quas.','1','1999-09-15 09:06:19','2011-04-11 00:12:40'),
('61','73','distinctio','Est et repudiandae error officiis dolore ex aliquid. Explicabo itaque odio veritatis ut iusto rerum nemo.','2','1991-04-21 23:58:53','1978-11-02 14:44:36'),
('62','45','aspernatur','Sed occaecati quis quis quia aut et corrupti ipsam. Ut sit reprehenderit aspernatur velit facilis. Quidem nisi temporibus sunt dolore explicabo aut.','1','2018-01-06 22:36:30','1976-03-15 13:48:31'),
('63','39','qui','Ut rerum aut est expedita nam. In dolorem blanditiis excepturi. Rerum error aliquid magnam architecto et et. Quo quisquam porro officiis et beatae dolor. Ea quia natus autem alias dolorem qui aliquid reiciendis.','3','1994-06-25 16:58:26','1974-05-29 11:01:10'),
('64','77','et','Ratione in libero sint. Rerum non iure ratione dignissimos qui amet omnis. Voluptatem omnis incidunt et ut. Fugiat hic perspiciatis veritatis reiciendis consequatur excepturi.','2','1973-06-07 20:10:48','1987-02-06 18:42:58'),
('65','60','eligendi','Quia sapiente blanditiis autem deleniti aut quod dicta. Rerum commodi aliquam asperiores magni optio. Quia at quas sint corrupti.','1','1983-02-16 09:37:55','1995-04-03 08:22:16'),
('66','28','labore','Perferendis ut beatae vel voluptas et porro. Est expedita explicabo ex. Dolorem minima deleniti qui voluptates sunt.','2','1970-03-17 05:20:38','2004-09-25 09:17:02'),
('67','41','accusamus','Doloribus minus est quidem sit aliquam at magnam. Voluptatem ad aut eum dolor qui unde rerum enim.','1','1998-02-11 15:07:37','2008-02-19 03:56:33'),
('68','96','quas','Consequatur aut quia soluta sit. Illum architecto laborum ut quia consequatur repellendus numquam. Iusto est expedita cumque et rerum et ullam.','3','2013-02-28 07:36:12','2011-04-28 09:13:52'),
('69','38','nobis','Magnam distinctio sit dolorum repellat aspernatur quibusdam. Laborum voluptatem doloribus doloremque nam. Tempore vel explicabo quia est iste quas.','3','1994-05-25 06:41:40','1986-04-30 11:46:08'),
('70','4','eaque','Consequatur ea voluptatem nihil. Sed recusandae cum qui magni. Sunt accusantium qui totam et qui non atque saepe. Praesentium hic excepturi debitis quia mollitia.','1','1995-01-07 13:02:20','2002-01-05 18:08:07'),
('71','60','ut','Iure repellendus tempora repellat porro. At quaerat ut suscipit nemo est modi sunt sequi. Officia et sunt quis minus voluptas labore.','3','1976-06-09 12:35:19','2013-04-24 11:05:46'),
('72','65','deserunt','Rem enim quam fugiat culpa. Deserunt qui beatae quos sunt autem. Neque dolores totam similique.','3','1981-09-06 00:47:17','2011-02-28 23:12:58'),
('73','40','laudantium','Id rerum laudantium facilis dicta doloremque tempora odio. Sunt culpa consequatur est molestiae. Sapiente velit qui totam exercitationem.','3','2010-09-13 03:55:35','2013-11-27 11:37:38'),
('74','5','omnis','Quia fugit quam qui. Doloribus quod et maxime. Eos necessitatibus optio praesentium dicta ratione consequuntur.','2','2013-03-30 06:54:33','1991-04-13 06:43:44'),
('75','26','laudantium','Id consequatur et dicta enim accusantium animi rerum earum. Non facere expedita facilis accusamus deleniti. Rem et aut earum optio. Dolores non autem voluptas. Sit odio est repellat eum.','3','1975-02-03 16:00:30','1977-09-22 08:07:45'),
('76','15','molestiae','Qui iste molestiae et adipisci. Maiores molestiae explicabo dolores. Aperiam consequatur veniam itaque mollitia facilis quasi qui magni.','1','1998-07-09 07:11:00','2010-06-11 09:14:26'),
('77','100','temporibus','Similique sed sed nihil harum iure consequatur eveniet et. Quas dolores magni consequatur sint necessitatibus rerum excepturi. Eaque vel a excepturi ad culpa omnis.','1','1996-09-02 21:16:04','1972-08-26 05:57:56'),
('78','91','saepe','Nobis maxime et dolores ratione consectetur ut et. Id voluptas aliquam eveniet libero. Tempora saepe ipsa quis natus dolore. Aperiam dolores nostrum rerum quia.','3','1974-10-28 00:26:02','2007-03-05 05:28:12'),
('79','63','dolore','Tenetur perferendis consequuntur quisquam qui. Quisquam enim exercitationem atque dolor blanditiis. Illo ut omnis delectus ut.','1','1989-03-05 15:34:11','2007-01-16 18:06:08'),
('80','12','iusto','Laborum eius expedita tempora excepturi voluptatem provident minus. Libero voluptatem veniam illum ullam architecto architecto est. Facere autem consequuntur labore eos sint cumque.','1','1998-05-29 16:50:04','2000-04-16 05:21:21'),
('81','13','consectetur','Odio ut id maxime. Neque dolorum quas repellendus et qui. Quos mollitia aut architecto enim et officia. Aspernatur eveniet aut tempora qui sint non.','3','2006-10-25 13:30:24','1985-08-24 12:06:02'),
('82','40','quibusdam','Nulla et maxime laboriosam accusamus voluptatem aliquid. Quae quos et ut sequi.','1','2005-09-01 16:40:45','2002-11-01 13:33:53'),
('83','39','sequi','Quo illo et non dolorum est. Repellat necessitatibus aut dolorem.','3','1980-02-18 02:16:48','1972-05-18 11:27:46'),
('84','30','iusto','Omnis et occaecati error provident fugiat. Quisquam velit inventore magni omnis libero beatae dolorem velit. Accusantium rerum necessitatibus tempora aut molestias.','2','2002-08-03 23:12:05','2013-07-21 16:01:35'),
('85','94','accusamus','Illo sit facere eum et sed odit unde. Quo nobis est commodi qui molestiae.','3','1997-06-20 21:06:08','1995-11-16 10:18:02'),
('86','80','reprehenderit','Ad expedita enim qui. Ut sunt dolor excepturi adipisci labore et. Sed quos ipsum rerum qui autem.','3','2005-03-02 17:49:46','2009-10-08 07:45:20'),
('87','57','placeat','Cum a temporibus qui illo praesentium. Ipsam quia praesentium aut et. Consequatur nostrum asperiores accusantium maiores non praesentium.','3','2001-08-18 02:41:16','2009-01-21 03:15:26'),
('88','77','nesciunt','Quam laboriosam ducimus et animi culpa eveniet. Unde doloremque quod temporibus exercitationem cum animi eveniet. Adipisci illo aut quo.','3','2008-03-03 03:35:26','1982-03-04 17:32:07'),
('89','95','omnis','Recusandae aspernatur magnam necessitatibus autem unde ratione sint. Ut rerum eius temporibus.','1','1971-01-18 03:49:05','2014-11-29 08:32:59'),
('90','100','hic','Architecto laboriosam assumenda doloribus eos dolorum quo earum. Provident numquam officiis id deleniti vel voluptatum quia. Alias deserunt voluptas omnis incidunt quasi error ut tenetur.','3','1979-09-27 07:38:42','1976-09-27 05:56:03'),
('91','53','ipsum','Adipisci nesciunt facere magni minima in. Cumque nemo voluptatem repellat soluta voluptatum fugit dolore. Aut hic qui voluptate ut.','1','1987-09-02 17:01:35','1998-08-29 19:53:02'),
('92','33','dolorum','Nihil provident est error. Minus placeat dolore sint tenetur. Et iusto minima voluptatum quis ut impedit. Dolorem eaque fugit qui fuga. Eius nisi recusandae omnis doloribus.','3','1999-04-29 13:50:48','1988-08-04 11:27:27'),
('93','7','ab','Velit qui consequatur quis. Quo deleniti ut porro velit ducimus dolorum. Quam enim repellendus necessitatibus corporis et eos natus.','2','2016-10-26 03:16:30','1984-09-04 11:12:52'),
('94','58','cum','Delectus velit dicta et saepe placeat. Ex quibusdam deserunt culpa ipsum aut. Explicabo harum aut repellat. Ipsam dolor ad iusto voluptatem.','2','2004-10-14 05:04:33','2008-04-06 22:01:41'),
('95','23','voluptatem','Ex voluptatem quia vero. Atque sint voluptate ea est sed porro. Aspernatur ut nostrum amet est voluptatem vel. Autem quasi consequatur et sit porro nisi.','3','2005-02-01 01:03:47','2007-12-18 16:17:05'),
('96','9','mollitia','Adipisci voluptatibus quod ab non dolores. Amet rerum recusandae dolores earum.','1','2016-01-16 16:39:39','1971-12-12 17:53:56'),
('97','66','sapiente','Sequi aut in quaerat in numquam quos illum. Molestiae suscipit aut mollitia ea. Ut quisquam nesciunt autem. Et nisi in commodi.','2','1994-09-07 05:54:38','2016-03-31 07:39:58'),
('98','85','quisquam','Rerum numquam cumque consectetur sit sit culpa. Quidem aut possimus maxime rerum et qui placeat. Architecto nostrum a ut ab nihil ex neque eaque. Occaecati itaque dignissimos autem provident sapiente.','1','2008-04-04 15:32:19','1994-10-10 18:34:22'),
('99','36','dolorem','Dolorem et molestiae laborum qui. At quod sed quasi hic et consequatur qui. Ea ea autem accusamus nesciunt ea.','3','2002-02-23 14:13:01','1979-09-24 21:00:18'),
('100','74','aut','Corrupti sed blanditiis doloribus consectetur soluta et nihil. Sapiente nemo eum qui. Architecto sunt enim numquam delectus eaque iste.','2','1976-11-25 00:37:58','1986-06-03 02:24:36'); 

