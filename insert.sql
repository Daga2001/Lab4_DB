-- % ============================================================================= %
-- a. Ejecute el script createdb.sql para llevar el esquema a PostgreSQL
-- b. Cada tabla debe contener al menos 5 filas. Se recomienda el uso de 
-- generadores de datos ficticios (dummy).
-- c. Se pueden considerar datos simples o inventados como "Profe 1", 
-- "Profe 2", "Curso I", "Curso II" u otros.
-- % ============================================================================= %
-- =============================================================================
-- ## Tabla student
-- =============================================================================
INSERT INTO student (name,program) VALUES
('student 1','program 1'),
('student 2','program 2'),
('student 3','program 3'),
('student 4','program 4'),
('student 5','program 5');
-- =============================================================================
-- ## Tabla instructor
-- =============================================================================
INSERT INTO instructor (name,dept,title) VALUES
('instructor 1','dept 1','software eng'),
('instructor 2','dept 1','computing eng'),
('instructor 3','dept 3','game design'),
('instructor 4','dept 4','medicine'),
('instructor 5','dept 5','medicine');
-- =============================================================================
-- ## Tabla course
-- =============================================================================
INSERT INTO course (title, syllabus, credits) VALUES
('course 1', 'syllabus 1', 2),
('course 2', 'syllabus 2', 3),
('course 3', 'syllabus 3', 4),
('course 4', 'syllabus 4', 5),
('course 5', 'syllabus 5', 9);
-- =============================================================================
-- ## Tabla course_offering
-- =============================================================================
INSERT INTO course_offering (course_id, year, semester, time, classroom) VALUES
(837827, '2022', '06', 2, 'sala 1011'),
(837850, '2021', '07', 3, 'sala 1012'),
(837873, '2020', '08', 4, 'sala 1013'),
(837896, '2019', '09', 5, 'sala 1014'),
(837919, '2018', '10', 6, 'sala 1015');
-- =============================================================================
-- ## Tabla enrolls
-- =============================================================================
INSERT INTO enrolls (student_id, course_id, semester, year, grade) VALUES
(7488, 837827, '06', '2022', 1),
(7656, 837850, '07', '2021', 3.5),
(7488, 837850, '07', '2021', 4.2),
(7824, 837873, '08', '2020', 4.5),
(7992, 837896, '09', '2019', 5.0),
(8160, 837919, '10', '2018', 2.4),
(8160, 837873, '10', '2018', 3.3),
(7488, 837873, '10', '2018', 4.1),
(7824, 837896, '08', '2020', 4.5),
(7488, 837896, '08', '2020', 4.6);
-- =============================================================================
-- ## Tabla teaches
-- =============================================================================
INSERT INTO teaches (course_id, semester, year, instructor_id) VALUES
(837827, '06', '2022', 1),
(837850, '07', '2021', 2),
(837873, '08', '2020', 3),
(837896, '09', '2019', 4),
(837919, '10', '2018', 5);
-- =============================================================================
-- ## Tabla requires     
-- =============================================================================                   
INSERT INTO requires (main_course, prerequisite) VALUES
(837896, 837827),
(837896, 837850),
(837896, 837873),
(837919, 837827),
(837919, 837850);