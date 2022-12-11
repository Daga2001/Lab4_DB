DO $$
BEGIN
-- =============================================================================
-- ## triggers
-- =============================================================================
DROP TRIGGER IF EXISTS fr_grade_insert ON enrolls;
DROP TRIGGER IF EXISTS fr_grade_update ON enrolls;
-- =============================================================================
-- ## functions
-- =============================================================================
DROP FUNCTION IF EXISTS check_insert_grade();
DROP FUNCTION IF EXISTS check_update_grade();
DROP FUNCTION IF EXISTS create_teaches();
-- =============================================================================
-- ## views
-- =============================================================================
IF EXISTS(SELECT table_name FROM 
        information_schema.tables 
    WHERE 
        table_schema LIKE 'public' AND 
        table_type LIKE 'VIEW' AND
        table_name = 'better_students') 
    THEN
    DROP VIEW better_students;
END IF;
-- =============================================================================
-- ## tables
-- =============================================================================
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename  = 'course_offering') THEN
    RAISE NOTICE 'table course_offering was deleted!';
    DROP TABLE course_offering;
END IF;
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename   = 'enrolls') THEN
    RAISE NOTICE 'table enrolls was deleted!';
    DROP TABLE enrolls;
END IF;
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename  = 'teaches') THEN
    RAISE NOTICE 'table teaches was deleted!';
    DROP TABLE teaches;
END IF;
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename  = 'requires') THEN
    RAISE NOTICE 'table requires was deleted!';
    DROP TABLE requires;
END IF;
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename  = 'student') THEN
    RAISE NOTICE 'table student was deleted!';
    DROP TABLE student;
END IF;
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename  = 'instructor') THEN
    RAISE NOTICE 'table instructor was deleted!';
    DROP TABLE instructor;
END IF;
IF EXISTS(SELECT tablename FROM pg_tables WHERE  
schemaname = 'public' AND tablename  = 'course') THEN
    RAISE NOTICE 'table course was deleted!';
    DROP TABLE course;
END IF;
-- =============================================================================
-- ## sequences
-- =============================================================================
IF EXISTS(SELECT relname FROM pg_class where relname = 'seq_student') THEN
    DROP SEQUENCE seq_student;
END IF;
IF EXISTS(SELECT relname FROM pg_class where relname = 'seq_course') THEN
    DROP SEQUENCE seq_course;
END IF;
-- =============================================================================
-- ## domains or types
-- =============================================================================
IF EXISTS(SELECT typname FROM pg_type WHERE typname = 'grade') THEN
    DROP DOMAIN grade;
END IF;
IF EXISTS(SELECT typname FROM pg_type WHERE typname = 'year') THEN
    DROP DOMAIN year;
END IF;
END $$;
-- =============================================================================
-- ## database - additional deletion
-- =============================================================================
DROP DATABASE IF EXISTS lab4db;