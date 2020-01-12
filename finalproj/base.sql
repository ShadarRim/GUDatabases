-- База посвящена работе университета

DROP DATABASE IF EXISTS university;
CREATE DATABASE IF EXISTS university;

-- Таблица человека

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

-- Таблицы статуса в университете (студент, преподавтаель, администратор)

DROP TABLE IF EXISTS university_statuses;
CREATE TABLE university_statuses (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(40)
);

-- Таблица соответствия человека и статуса

DROP TABLE IF EXISTS persons_statuses;
CREATE TABLE persons_statuses (
	person_id INT UNSIGNED NOT NULL,
	status_id INT UNSIGNED NOT NULL
	PRIMARY KEY (person_id, status_id)
);