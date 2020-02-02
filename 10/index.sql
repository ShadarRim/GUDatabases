USE vk;

#����� ��������� �� ��������
CREATE INDEX birthday_prodiles_idx ON profiles(birthday) ;

#��������, ���� ����� �������� ������ ���������, �� ���� ����� ������ �������� �������
CREATE INDEX size_media_idx ON media(size);

#������� ����� ���� �� �����
CREATE INDEX name_meetings_idx ON meetings(name);

#���������� ��� ��������� 
CREATE INDEX name_communities_idx ON communities(name);

#� ������ �� �������
CREATE INDEX users_last_name_idx ON users(last_name);
