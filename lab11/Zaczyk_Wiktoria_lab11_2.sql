-- 5. Korzystając z przykładu jdbc_ex05.java napisać funkcję wymienioną w programie

CREATE OR REPLACE FUNCTION lab04.f1_osoba ( id int)
RETURNS TABLE (naz varchar, imie varchar, email varchar) AS
$$
BEGIN
    RETURN QUERY
    SELECT u.nazwisko, u.imie, u.email FROM lab04.uczestnik u
    WHERE id_uczestnik = id;
END;
$$
LANGUAGE 'plpgsql';

-- 6. Korzystając z przykładu jdbc_ex06.java napisać funkcję wymienioną w programie.
CREATE OR REPLACE FUNCTION lab04.get_table ()
RETURNS TABLE (id int, imie varchar, naz varchar) AS
$$
BEGIN
    RETURN QUERY
    SELECT u.id_uczestnik, u.imie, u.nazwisko FROM lab04.uczestnik u;
END;
$$
LANGUAGE 'plpgsql';


-- 7. Korzystając z przykładu jdbc_ex07.java uzupełnić funkcję wymienioną w programie.
CREATE OR REPLACE FUNCTION lab04.get_cursor() 
RETURNS refcursor AS
$body$
DECLARE curuczestnik refcursor  ;
BEGIN
  OPEN curuczestnik FOR SELECT id_uczestnik, imie, nazwisko FROM lab04.uczestnik;
  RETURN curuczestnik ;
END;
$body$ 
LANGUAGE 'plpgsql';