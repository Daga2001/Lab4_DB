-- =============================================================================
-- ## Create database
-- =============================================================================
CREATE DATABASE mockup001
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    TEMPLATE template0;

    \c mockup001;
-- =============================================================================
-- ## Create sequences
-- a. El atributo student_id inicia en 7488 con un incremento de 168 cada vez que 
-- se inserta un estudiante.
-- b. El atributo course_id inicia en 837827 con un incremento de 23.
-- =============================================================================
-- students
CREATE SEQUENCE seq_student
INCREMENT 168
START 7488; -- ## SERIAL's starting point.
-- courses
CREATE SEQUENCE seq_course
INCREMENT 23
START 837827; -- ## SERIAL's starting point.
-- =============================================================================
-- ## Create types or domains
-- c. El tipo de dato del atributo grade de la tabla enrolls es NUMERIC con 
-- dos decimales, superior a 1.00 y menor a 5.00
-- =============================================================================
-- ## grades
CREATE DOMAIN grade AS NUMERIC(3,2)
CONSTRAINT possible_grades
CHECK (
    VALUE >=1.0 AND VALUE <=5.0
);
-- ## years
CREATE DOMAIN year AS INTEGER
CONSTRAINT possible_years
CHECK
(
    VALUE >=1900 AND VALUE <= 2022
);
-- =============================================================================
-- ## Tabla student
-- =============================================================================
CREATE TABLE student (
    student_id INT PRIMARY KEY DEFAULT NEXTVAL('seq_student'),
    name VARCHAR(100) NOT NULL,
    program VARCHAR(100) NOT NULL
);
-- =============================================================================
-- ## Tabla instructor
-- =============================================================================
CREATE TABLE instructor (
    instructor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL
);
-- =============================================================================
-- ## Tabla course
-- =============================================================================
CREATE TABLE course (
    course_id INT PRIMARY KEY DEFAULT NEXTVAL('seq_course'),
    title VARCHAR(100) NOT NULL,
    syllabus VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL
);
-- =============================================================================
-- ## Tabla course_offering
-- =============================================================================
CREATE TABLE course_offering (
    course_id INT,
    sec_id SERIAL,
    year year,
    semester VARCHAR(2),
    time INT NOT NULL,
    classroom VARCHAR(20) NOT NULL,
    PRIMARY KEY (course_id,sec_id,year,semester),
    CONSTRAINT fk_course
      FOREIGN KEY(course_id) 
	  REFERENCES course(course_id)
);
-- =============================================================================
-- ## Tabla enrolls
-- =============================================================================
CREATE TABLE enrolls (
    student_id INT,
    course_id INT,
    sec_id SERIAL,
    semester VARCHAR(2),
    year year,
    grade grade NOT NULL,
    PRIMARY KEY (student_id,course_id,sec_id,year,semester),
    CONSTRAINT fk_student
      FOREIGN KEY(student_id) 
	    REFERENCES student(student_id),
    CONSTRAINT fk_course
      FOREIGN KEY(course_id) 
	    REFERENCES course(course_id)
);
-- =============================================================================
-- ## Tabla teaches
-- =============================================================================
CREATE TABLE teaches (
    instructor_id INT,
    course_id INT,
    sec_id SERIAL,
    semester VARCHAR(2),
    year year,
    PRIMARY KEY (instructor_id,course_id,sec_id,year,semester),
    CONSTRAINT fk_instructor
      FOREIGN KEY(instructor_id) 
	    REFERENCES instructor(instructor_id),
    CONSTRAINT fk_course
      FOREIGN KEY(course_id) 
	    REFERENCES course(course_id)
);
-- =============================================================================
-- ## Tabla requires
-- =============================================================================
CREATE TABLE requires (
    main_course INT,
    prerequisite INT,
    PRIMARY KEY (main_course,prerequisite),
    CONSTRAINT fk_prerequisite
      FOREIGN KEY(prerequisite) 
	    REFERENCES course(course_id),
    CONSTRAINT fk_course
      FOREIGN KEY(main_course) 
	    REFERENCES course(course_id)
);