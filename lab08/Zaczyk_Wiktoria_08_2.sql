-- 1. Napisać wyzwalacz walidujący fname i lname w tabeli person, 
--tylko litery, bez spacji i tabulatorów. 
--W lname dopuszczalny znak - (myślnik, pauza).
---
CREATE OR REPLACE FUNCTION lab04.validate_input ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
    IF LENGTH(TRIM(NEW.secondary_group)) = 0 OR (NEW.fname = ' ' OR NEW.fname = '\t') OR (NEW.lname = ' ' OR NEW.lname = '\t') THEN
        RAISE EXCEPTION 'Niepoprawne wartości. Bez spacji i tabulatorów';
    ELSIF NEW.lname NOT LIKE '[a-z]+' OR (NEW.fname NOT LIKE '[a-z]+') THEN
        RAISE EXCEPTION 'Niepoprawne wartości. Tylko litery!';
    END IF;
  
    RETURN NEW;                                                          
    END;
$$;


CREATE TRIGGER person_valid 
    AFTER INSERT OR UPDATE OR DELETE ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.validate_input(); 

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'wwa', 'Ant', 'P', 'WY' );
SELECT * FROM lab04.person;
UPDATE lab04.person SET primary_group = 'A' WHERE fname = 'Ant' AND lname = 'Dyd';
DELETE FROM lab04.person WHERE fname = 'Ant' AND lname = 'Dyd'; 

DROP TRIGGER person_valid ON lab04.person
----


-- 2. Napisać wyzwalacz normalizujący fname i lname w tabeli person,
-- fname i skladowe lname ( przy podwójnym nazwisku) 
--powinny zaczynać się od dużej litery, reszta małe. Usuwamy spacje.

CREATE OR REPLACE FUNCTION lab04.normalizuj_data () RETURNS TRIGGER AS $$
BEGIN
	IF LENGTH(TRIM(NEW.fname)) = 0 THEN
        RAISE EXCEPTION 'Brak wartości fname.';
    END IF;
    IF LENGTH(TRIM(NEW.lname)) = 0 THEN
            RAISE EXCEPTION 'Brak wartości lname.';
        END IF;
        NEW.lname := UPPER(LEFT(NEW.lname,1)) || LOWER(SUBSTRING(NEW.lname,2,LENGTH(NEW.lname)));
        NEW.fname := UPPER(LEFT(NEW.fname,1)) || LOWER(SUBSTRING(NEW.fname,2,LENGTH(NEW.fname)));
  RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


-- Przypisanie wyzwalacza do tabeli person
CREATE TRIGGER person_normalizuj
  BEFORE INSERT OR UPDATE ON lab04.person
  FOR EACH ROW
  EXECUTE PROCEDURE lab04.normalizuj_data();
 

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Mic', 'Jan', 'S', '' );  
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Mic', 'Jan', 'A', 'Wy' );  
INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Mic', 'Jan', 's', 'wy' );
SELECT * FROM lab04.person;



-- 3. Napisać wyzwalacz aktualizujący tabelę zawierającą 
--liczbę wszystkich osób w danej grupie. 
--Uwzględnić insert, delete i update.

CREATE OR REPLACE FUNCTION lab04.person_view_dml () RETURNS TRIGGER AS $$
	DECLARE last_id INTEGER;
   BEGIN                                                                                                      
    IF TG_OP = 'INSERT' THEN                                                                                  
      INSERT INTO  lab04.person (fname, lname, primary_group, secondary_group) 
      VALUES (NEW.fname,NEW.lname, NEW.primary_group, NEW.secondary_group)
      RETURNING person_id INTO last_id;
--      SELECT currval(pg_get_serial_sequence('person','person_id')) INTO last_id;
      INSERT INTO lab04.person_data VALUES(last_id, NEW.city, NEW.email, NEW.telefon);
      RETURN NEW;                                                                                             
    ELSIF TG_OP = 'UPDATE' THEN                                                                               
      UPDATE lab04.person SET fname=NEW.fname, lname=NEW.lname WHERE person_id=OLD.person_id;                   
      UPDATE lab04.person_data SET id=NEW.person_id, city=NEW.city, email=NEW.email, telefon=NEW.telefon WHERE id=OLD.person_id;
      RETURN NEW;                                                                                             
    ELSIF TG_OP = 'DELETE' THEN                                                                               
      DELETE FROM lab04.person WHERE person_id=OLD.person_id;                                                                     
      DELETE FROM lab04.person_data WHERE id=OLD.person_id;                                                                
      RETURN NULL;                                                                                            
    END IF;                                                                                                   
    RETURN NEW;                                                                                               
  END; 
$$ LANGUAGE 'plpgsql';

--DROP TRIGGER person_v_dml_trig ON lab04.person_v;

CREATE TRIGGER person_v_dml_trig  
    INSTEAD OF INSERT OR UPDATE OR DELETE ON lab04.person_view
    FOR EACH ROW EXECUTE PROCEDURE lab04.person_view_dml(); 
    
UPDATE lab04.person_view SET city = 'Cracow' WHERE person_id = 12;

INSERT INTO lab04.person_view ( fname, lname, primary_group, secondary_group, city, email, telefon )
VALUES ( 'Maz', 'Kam', 's', 'py', 'Wrocław', 'maz.kam@agh.edu.pl', NULL)

INSERT INTO lab04.person_view ( fname, lname, primary_group, secondary_group, city, email, telefon )
VALUES ( 'Nal', 'Zyg', 'S', 'PY', 'Gdańsk', 'nal.zyg@agh.edu.pl', NULL) 
   
  
--    DROP TRIGGER person_view_dml_trig ON lab04.person_v;
--    DROP FUNCTION  lab04.person_view_dml ();


CREATE TABLE lab04.pg_data ( pg varchar(30), cnt int);
CREATE TABLE lab04.sg_data ( sg varchar(30), cnt int);

CREATE OR REPLACE FUNCTION lab04.insert_data ()
    RETURNS TRIGGER
    AS $$
    BEGIN
        DELETE FROM pg_data;
        DELETE FROM sg_data;
        insert into lab04.pg_data(pg, cnt) select primary_group, count(*) from person group by primary_group;
        insert into lab04.sg_data(sg, cnt) select secondary_group, count(*) from person group by secondary_group;
        RETURN NEW;
    END;
    $$ LANGUAGE 'plpgsql';

CREATE TRIGGER person_insert
    AFTER INSERT ON lab04.person
    FOR EACH ROW EXECUTE PROCEDURE lab04.insert_data();

INSERT INTO lab04.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Bie', 'Zyg', 'S', 'C+' );