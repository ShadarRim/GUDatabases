USE university;

ALTER TABLE persons_statuses
	DROP FOREIGN KEY persons_statuses_person_id_fk,
	DROP FOREIGN KEY persons_statuses_university_status_id_fk;

-- не отображается диаграмма 

ALTER TABLE persons_statuses
	ADD CONSTRAINT persons_statuses_person_id_fk
		FOREIGN KEY (person_id) REFERENCES persons(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT persons_statuses_university_status_id_fk
		FOREIGN KEY (status_id) REFERENCES university_statuses(id);
	
SHOW CREATE TABLE persons_statuses;
		
SELECT achivments.type_id FROM achivments;
SELECT * FROM achive_types;	

-- не ясна суть ошибки

ALTER TABLE achivments
	ADD CONSTRAINT achivments_achive_types_fk
		FOREIGN KEY (type_id) REFERENCES achive_types(id);