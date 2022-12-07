-- ================================================================================
-- a. Encuentre el dept, title de los instructores registrados en la base de datos.
-- ================================================================================
SELECT dept, title FROM instructor;

-- ================================================================================
-- b. Indique el nombre y programa del estudiante con student_id = 7656
-- ================================================================================
SELECT name, program FROM student where student_id = 7656;

-- ================================================================================
-- c. Encuentre los nombres de todos los estudiantes que se han matriculado en 
-- el curso con course_id = 837873
-- ================================================================================
SELECT name
FROM enrolls 
NATURAL JOIN student
NATURAL JOIN course
WHERE course_id = 837873;

-- ================================================================================
-- d. Cree una vista llamada better_students que presente los estudiantes que 
-- obtuvieron las notas más altas por cada semestre entre los años 1900 y 2018
-- ================================================================================
CREATE VIEW better_students AS
    SELECT max(name) student_name, max(title) title, max(grade) grade, semester, year
    FROM enrolls 
    NATURAL JOIN student
    NATURAL JOIN course
    GROUP BY semester, year
    ORDER BY year DESC, semester DESC;
