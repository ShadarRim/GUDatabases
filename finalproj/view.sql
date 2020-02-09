USE university;

DROP VIEW student_courses_names;

CREATE VIEW student_courses_names AS (
	SELECT persons.first_name, persons.last_name, courses.name
	FROM persons
	JOIN students_courses
		ON persons.id = students_courses.student_id
	JOIN courses
		ON students_courses.course_id = courses.id
);

SELECT * FROM student_courses_names;

CREATE VIEW courses_rooms_names AS (
	SELECT courses.name, rooms.room_number
	FROM courses
	JOIN courses_rooms
		ON courses.id = courses_rooms.course_id
	JOIN rooms
		ON courses_rooms.room_id = rooms.id
);

SELECT * FROM courses_rooms_names;