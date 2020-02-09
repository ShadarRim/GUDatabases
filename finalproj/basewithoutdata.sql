-- ���� ��������� ������ ������������

DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;

-- ������� ��������

DROP TABLE IF EXISTS persons;
CREATE TABLE persons (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
  	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(120) NOT NULL UNIQUE,
	phone VARCHAR(120) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- ������� ������� � ������������ (�������, �������������, �������������)

DROP TABLE IF EXISTS university_statuses;
CREATE TABLE university_statuses (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(40)
);

-- ������� ������������ �������� � �������

DROP TABLE IF EXISTS persons_statuses;
CREATE TABLE persons_statuses (
	person_id INT UNSIGNED NOT NULL,
	status_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (person_id, status_id)
);

-- ������� ������

DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	coure_length_week INT UNSIGNED NOT NULL,
	max_students INT UNSIGNED DEFAULT 0
);

-- ������������� ������

DROP TABLE IF EXISTS teachers_courses;
CREATE TABLE teachers_courses (
	teacher_id INT UNSIGNED NOT NULL,
	course_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (teacher_id, course_id)
);

-- �������� ������

DROP TABLE IF EXISTS students_courses;
CREATE TABLE students_courses (
	student_id INT UNSIGNED NOT NULL,
	course_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (student_id, course_id)
);

-- ���������

DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
	id SERIAL PRIMARY KEY,
	room_number VARCHAR(255),
	max_students INT UNSIGNED,
	room_type INT UNSIGNED
);

-- ���� ���������

DROP TABLE IF EXISTS room_types;
CREATE TABLE room_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

-- ���� ���� ����� ��������� � ���������� ���������� 

DROP TABLE IF EXISTS courses_rooms;
CREATE TABLE courses_rooms (
	id SERIAL PRIMARY KEY,
	course_id INT UNSIGNED,
	room_id INT UNSIGNED
);

-- ������� ���������� ��������

DROP TABLE IF EXISTS achivments;
CREATE TABLE achivments (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	type_id INT UNSIGNED
);

-- ������� ����� ����������

DROP TABLE IF EXISTS achiv_types;
CREATE TABLE achive_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

-- ���� ���������� ����� ����� ��������� �������

DROP TABLE IF EXISTS achiv_persons;
CREATE TABLE achiv_persons (
	person_id INT UNSIGNED,
	achiv_id INT UNSIGNED,
	PRIMARY KEY (achiv_id, person_id)
)
