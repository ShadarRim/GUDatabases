USE university;

ALTER TABLE persons_statuses
	DROP FOREIGN KEY persons_statuses_person_id_fk,
	DROP FOREIGN KEY persons_statuses_university_status_id_fk;


ALTER TABLE persons_statuses
	ADD CONSTRAINT persons_statuses_person_id_fk
		FOREIGN KEY (person_id) REFERENCES persons(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT persons_statuses_university_status_id_fk
		FOREIGN KEY (status_id) REFERENCES university_statuses(id);
	
ALTER TABLE courses_rooms
	ADD CONSTRAINT courses_rooms_rooms_id_fk
		FOREIGN KEY (room_id) REFERENCES rooms(id),
	ADD CONSTRAINT courses_rooms_courses_id_fk
		FOREIGN KEY (course_id) REFERENCES courses(id);
	
ALTER TABLE achiv_persons 
	ADD CONSTRAINT persons_achiv_persons_id_fk
		FOREIGN KEY (person_id) REFERENCES persons(id),
	ADD CONSTRAINT achivments_achiv_persons_id_fk
		FOREIGN KEY (achiv_id) REFERENCES achivments(id);
	
ALTER TABLE students_courses
	ADD CONSTRAINT students_courses_persons_id_fk
		FOREIGN KEY (student_id) REFERENCES persons(id),
	ADD CONSTRAINT students_courses_courses_id_fk
		FOREIGN KEY (course_id) REFERENCES courses(id);	
	
SHOW CREATE TABLE persons_statuses;
		
SELECT achivments.type_id FROM achivments;
SELECT * FROM achive_types;	

ALTER TABLE achivments
	ADD CONSTRAINT achivments_achive_types_fk
		FOREIGN KEY (type_id) REFERENCES achive_types(id);
		
ALTER TABLE rooms
	ADD CONSTRAINT rooms_rooms_types_fk
		FOREIGN KEY (room_type) REFERENCES room_types(id);