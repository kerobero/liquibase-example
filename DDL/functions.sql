-- liquibase formatted sql
-- changeset changelog:fn_increment splitStatements:false runOnChange:true
CREATE OR REPLACE FUNCTION increment(i integer) RETURNS integer AS $$ BEGIN RETURN i + 1;
END;
$$ LANGUAGE plpgsql;