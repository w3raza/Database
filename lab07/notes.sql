DO $$
DECLARE 
i INTEGER := 0;
BEGIN
LOOP -- 
EXIT WHEN i>9; -- WHILE i<10 LOOP
i:=i+1;
RAISE NOTICE 'i: %', i;
END LOOP;
END; $$;

CREATE FUNCTION lab04.silnia (n integer) 
RETURNS BIGINT AS
$$                   --otwarcie bloku programowego
DECLAREi INTEGER := 0;
sil BIGINT := 1;
BEGIN
LOOP
EXIT WHEN i>=n;
i := i + 1;
sil := sil * i;
END LOOP;
RETURN sil;
END;                                                             $$                   --zamknięcie bloku programowegoLANGUAGE plpgsql;    --deklaracja języka


LANGUAGE plpsql;

SELECT lab04.silnia(21);

CREATE OR REPLACE FUNCTION lab04.getnazwisko ( int ) RETURNS text AS
$$
DECLARE
id ALIAS FOR $1;                 --przypisanie atrybutu do parametru
name lab04.uczestnik.nazwisko%TYPE;       --przypisanie typu kolumnydo zmiennej 
BEGIN
SELECT INTO name nazwisko FROM lab04.uczestnik 
WHERE id_uczestnik = id ;
RETURN name;
END;
$$ LANGUAGE 'plpgsql';


SELECT lab04.getnazwisko(1);
DROP FUNCTION lab04.getnazwisko ( int );

CREATE OR REPLACE FUNCTION lab04.getperson ( int ) RETURNS text AS
$$
DECLARE
id ALIAS FOR $1;                 --przypisanie atrybutu do parametru
person lab04.uczestnik%ROWTYPE;        --przypisanie typu kolumnydo zmiennej 
BEGIN
SELECT * INTO person FROM lab04.uczestnik 
WHERE id_uczestnik = id ;
RETURN erson.nazwisko || ' ' || person.imie;
END;
$$ LANGUAGE 'plpgsql';


SELECT lab04.getperson(4);
DROP FUNCTION lab04.getperson(int);

CREATE OR REPLACE FUNCTION lab04.getpersondata ( int ) 
RETURNS text AS
$$
DECLARE
id ALIAS FOR $1;
person RECORD;     --przypisanie typu RECORD
BEGIN
SELECT  imie, nazwisko INTO person FROM lab04.uczestnik 
WHERE id_uczestnik = id ;
RETURN person.nazwisko || ' ' || person.imie ;
END;
$$ 
LANGUAGE 'plpgsql';

SELECT lab04.getpersondata(5) ;