-- =============================================================================
-- ## TRIGGERS
-- a. Cree uno o varios disparadores (triggers) que implemente los siguiente 
-- requerimientos para la relación enrolls 
-- =============================================================================
-------------------------------------------------------------------------------
-- ## i. Al agregar una tupla en enrolls, en caso de que la nota sea negativa, 
-- cero (0.0) o mayor de 5.00 se debe generar una excepción indicando que el 
-- valor a guardar en grade es incorrecto o invalido.
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION check_insert_grade() 
RETURNS TRIGGER 
AS $$
    BEGIN        
        IF NEW.grade < 0 OR NEW.grade > 5.00 THEN
            BEGIN
                RAISE EXCEPTION 'la nota que se va a insertar es invalida: %', NEW.grade;
            END;
        ELSE
            RETURN NEW;
        END IF;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER fr_grade_insert
BEFORE INSERT ON enrolls
FOR EACH ROW EXECUTE PROCEDURE check_insert_grade();
-------------------------------------------------------------------------------
-- ## ii. Durante la actualización de un registro si el valor grade es 
-- modificado, usando RAISE NOTICE se debe presentar un mensaje indicando 
-- el cambio, si es igual al valor grade en la tabla se debe indicar que el 
-- valor no ha sido modificado. Si el grade a actualizar es negativo, cero o 
-- mayor de cinco use RAISE EXCEPTION.
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION check_update_grade() 
RETURNS TRIGGER 
AS $$
    BEGIN        
        IF NEW.grade < 0 OR NEW.grade > 5.00 THEN
            BEGIN
                RAISE EXCEPTION 'La nota que se va a insertar es invalida: %', NEW.grade;
            END;
        ELSE
            IF NEW.grade = OLD.grade THEN
                RAISE NOTICE 'la nota no ha sido modificada y su valor persiste: %', OLD.grade;
                RETURN NEW;
            ELSE
                RAISE NOTICE 'la nota ha sido modificada de (%) a (%)', OLD.grade, New.grade;
                RETURN NEW;
            END IF;
        END IF;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER fr_grade_update
BEFORE UPDATE ON enrolls
FOR EACH ROW EXECUTE PROCEDURE check_update_grade();
-- -----------------------------------------------------------------------------
-- test queries
-- -----------------------------------------------------------------------------
INSERT INTO enrolls (grade) VALUES (-9);

UPDATE enrolls 
SET grade = 1
WHERE grade = 1;
-- =============================================================================
-- ## PROCEDURES   
-- b. Cree un procedimiento create_teaches que automáticamente agregue un 
-- registro a teaches. Este recibe dos argumentos un identificador de instructor 
-- instructor_id y un identificador de course_id. Se asume que ambos existen en 
-- la base de datos.
-- i. Este procedimiento debe verificar que el curso exista en la oferta de cursos.
-- ii. Use curse_id, sec_id, year y semester de la oferta de curso y 
-- instructor_id el para insertar en teaches.
-- =============================================================================
CREATE OR REPLACE FUNCTION create_teaches(i_id INT, c_id INT) 
RETURNS VOID
AS 
$$
    BEGIN
        IF EXISTS(SELECT instructor_id FROM teaches where instructor_id = i_id) 
        AND EXISTS(SELECT course_id FROM teaches where course_id = c_id) THEN
            INSERT INTO teaches (course_id, sec_id, semester, year, instructor_id) 
            SELECT course_id, sec_id, semester, year, i_id instructor_id
            FROM course_offering WHERE course_id = c_id;
        ELSE
            RAISE EXCEPTION 'El registro a insertar tiene un identificador inexistente!';
        END IF;
    END;
$$ LANGUAGE plpgsql;
-- -----------------------------------------------------------------------------
-- test queries
-- -----------------------------------------------------------------------------
SELECT create_teaches(1,837827);