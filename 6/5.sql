USE vk;

SHOW TABLES;

-- ���������� ��� ���� - ����� ���������� ������������ ������, ������������ ��������� � ����������� ����� ���������� (������ ����� ��� ������� ����������)
-- � �������� ����� ��������� ����������� � ������� �������� � ����� ���������� �����

SELECT user_id, SUM(num) as sumnum FROM (
	SELECT id as user_id, 0 as num from users
	UNION ALL
	SELECT user_id, COUNT(*) as num FROM likes GROUP BY user_id
	UNION ALL
	SELECT from_user_id as user_id, COUNT(*) as num FROM messages GROUP BY from_user_id
	UNION ALL
	SELECT user_id, COUNT(*) as num FROM media GROUP BY user_id) AS subtub
GROUP BY user_id
ORDER BY sumnum
LIMIT 10;
