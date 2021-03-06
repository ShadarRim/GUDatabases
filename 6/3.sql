USE vk;

SHOW TABLES;
SELECT * FROM likes;
SELECT * FROM profiles;
-- users - id 2
SELECT * FROM target_types;

-- ���� ������ ���������� ��� 10 ����� ������� �������������

SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;

-- � ���� ������� ����� ������������

SELECT target_id, COUNT(*) as count_likes FROM likes WHERE target_type_id = 2 GROUP BY target_id;

-- � ������ �� �� ��������� ������, ��� � WHERE ������ �������� ��������� � LIMIT

-- ��������!
SELECT target_id as target, COUNT(*) as count_likes FROM likes WHERE target_type_id = 2 GROUP BY target_id;


-- ��������� ������ �1
SELECT SUM(tab2.likes_count) FROM
	(SELECT subtab.target_id, subtab.bd, COUNT(*) as likes_count FROM
		(SELECT id, target_id, (SELECT birthday FROM profiles WHERE profiles.user_id = target_id) as bd FROM likes WHERE target_type_id = 2) AS subtab
	GROUP BY subtab.target_id
	ORDER BY subtab.bd DESC
	LIMIT 10) as tab2
;

-- ��� ������� �2
SELECT SUM(count_likes) FROM (
	SELECT target_id, COUNT(*) as count_likes FROM likes WHERE target_type_id = 2 AND target_id IN
	(SELECT * FROM
		(SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) as tab)
	GROUP BY target_id) AS fintab;

-- �������� ��������, ��� ������ �� ��������
-- �� ���� � ���, ��� ������ ������ ������� �����, � �������������, � ����� ��������� �� ��������
-- ������ �� ������ ������� ������� ���-10 �� ��������, ������ ������� �� ����� (������ ���������)
-- � ����� �� ������� ������� ���� ������������, ������� �� � ���-10 ������, �� ������ �� ��������
-- � � ������ ������� ���-10 �� ��� ��� ������� �����




