USE university;

-- запрашиваем количество студентов на курс

SELECT DISTINCT courses.name,
		MAX(persons.created_at) OVER w AS 'early_b',
		COUNT(*) OVER w AS 'students_count'
	FROM courses
	JOIN students_courses
		ON students_courses.course_id = courses.id
	JOIN persons
		ON persons.id = students_courses.student_id
	WINDOW w AS (PARTITION BY courses.id);

-- найти топ-10 студентов, которые стали студентами совсем недавно и уже получили достижения в учёбе id=2

SELECT persons.id, persons.first_name, persons.last_name,achivments.name as 'ach_name' FROM achivments
	JOIN achiv_persons
		ON achivments.id = achiv_persons.achiv_id
	JOIN persons
		ON persons.id = achiv_persons.person_id
	WHERE achivments.type_id = '2'
	ORDER BY persons.created_at DESC
	LIMIT 10;
	
-- определить общее количество свободных от занятий аудиторий

SELECT COUNT(*) FROM (
SELECT rooms.id, room_number, max_students FROM rooms
	LEFT JOIN courses_rooms
		ON courses_rooms.room_id = rooms.id
	WHERE rooms.room_type = '1' AND courses_rooms.id IS NULL
	GROUP BY rooms.id ) AS sabtab;
