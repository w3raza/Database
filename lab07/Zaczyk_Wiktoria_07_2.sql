-- -- 1. Utworzyć funkcję,  która dostarcza listę z nazwiskami, 
-- imionami i adresem email uczestników dla organizacji. 

-- Identyfikator organizacji jest argumentem funkcji.

CREATE OR REPLACE FUNCTION lab04.lista (idorg int)
RETURNS TABLE (nazwisko VARCHAR, imie VARCHAR, email VARCHAR) AS
$$
BEGIN
    RETURN QUERY
    SELECT u.nazwisko, u.imie, u.email FROM lab04.uczestnik U 
    JOIN lab04.uczestnik_organizacja UORG USING(id_uczestnik)
    WHERE uorg.id_organizacja = idorg;
END;
$$
LANGUAGE 'plpgsql';

SELECT * FROM lab04.lista(1);
DROP FUNCTION lab04.lista(INT);

--   nazwisko   |   imie    |           email            
-- -------------+-----------+----------------------------
--  Flisikowski | Jan       | flisikowski@fis.agh.edu.pl
--  Olech       | Andrzej   | 
--  Płochocki   | Piotr     | 
--  Stachyra    | Krzysztof | 
--  Sztuka      | Stanisław | 
--  Sosin       | Tomasz    | 
--  Głowala     | Paweł     | glowala@fis.agh.edu.pl
--  Straszewski | Józef     | 
--  Dwojak      | Marcin    | 
--  Kotulski    | Marek     | 
--  Łaski       | Michał    | laski@fis.agh.edu.pl
--  Iwanowicz   | Grzegorz  | 
--  Barnaś      | Jerzy     | 
--  Stachera    | Tadeusz   | 
--  Sielicki    | Dariusz   | 
--  Szcześniak  | Mariusz   | 
--  Hołownia    | Mateusz   | 
-- (17 rows)


-- -- 2. Utworzyć funkcję,  która dostarcza ilość studentów dla 
-- kursów danego języka. Nazwa języka jest argumentem funkcji.

CREATE OR REPLACE FUNCTION lab04.jezyk(opis varchar)
RETURNS bigint AS
$$
    SELECT count(*) FROM lab04.kurs_opis KO
    JOIN lab04.kurs KU ON ku.id_nazwa = ko.id_kurs
    JOIN lab04.uczest_kurs UK on KU.id_kurs = KO.id_kurs
    JOIN lab04.uczestnik UCZ on UCZ.id_uczestnik = uk.id_uczest
    WHERE opis like CONCAT(CONCAT('%', opis),'%');
$$
LANGUAGE SQL;

SELECT * FROM lab04.jezyk('Język angielski%');
DROP FUNCTION lab04.jezyk(VARCHAR);

--  jezyk 
-- -------
--    296
-- (1 row)

-- -- 3. Utworzyć funkcję,  która dostarcza listę wykładowców 
-- prowadzących kursy dla zadanej organizacji. 

CREATE OR REPLACE FUNCTION lab04.lista_wykladowcow(adres_www VARCHAR)
RETURNS TABLE(nazwisko VARCHAR, imie VARCHAR) AS
$$
    SELECT nazwisko, imie
    FROM lab04.wykladowca WY
    JOIN lab04.uczestnik_organizacja UO USING(id_wykladowca)
    JOIN lab04.organizacja ORG USING(id_organizacja)
    WHERE org.strona_www like adres_www;
$$
LANGUAGE SQL;

-- Argumentem funkcji jest adres strony np. www.uj.edu.pl.
SELECT * FROM lab04.lista_wykladowcow('www.uj.edu.pl');
DROP FUNCTION lab04.lista_wykladowcow(VARCHAR);

--   nazwisko   |  imie   
-- -------------+---------
--  Szymczak    | Marcin
--  Baranowska  | Joanna
--  Szczepański | Maciej
--  Wróbel      | Czesław
--  Górska      | Grażyna
--  Krawczyk    | Wanda
-- (6 rows)

-- -- 4. Utworzyć funkcję,  która zwraca napis ( string) 
-- którego zawartością jest lista. Wiersze listy zawierają  
-- opis kursu, data rozpoczęcia, data zakończenia oddzielone średnikami. 
-- Każdy wiersz jest umieszczony w nawiasach () i oddzielony przecinkiem.

CREATE OR REPLACE FUNCTION lab04.napis()
RETURNS text AS
$$
    DECLARE
    id INTEGER;
        rec RECORD;
        records TEXT DEFAULT '';
    BEGIN
        id := 0;
        FOR rec IN (SELECT opis, data_rozpoczecia ,data_zakonczenia FROM lab04.kurs_opis JOIN lab04.kurs ON kurs_opis.id_kurs=kurs.id_nazwa )
        LOOP
        IF id != 0 THEN
            records := records || ',' || '(' || rec.opis || ';' || rec.data_rozpoczecia || ';' || rec.data_zakonczenia || ')';
        END IF;

        IF id = 0 THEN
            records := '(' || rec.opis || ';' || rec.data_rozpoczecia || ';' || rec.data_zakonczenia || ')';
        id := 1 ;
        END IF;    
        END LOOP;
    RETURN records;
END;
$$
LANGUAGE 'plpgsql';

SELECT * FROM lab04.napis();
DROP FUNCTION lab04.napis();

--  (Język angielski, stopień 1;2021-01-01;2021-03-31),(Język angielski, stopień 1;2021-01-01;2021-03-31),(Język angielski, stopień 2;2021-04-01;2021-06-30),(Język angielski, stopień 3;2021-08-01;2021-10-10),(Język angielski, stopień 4;2021-11-01;2021-12-23),(Język niemiecki, stopień 1;2021-01-01;2021-03-31),(Język niemiecki, stopień 1;2021-01-01;2021-03-31),(Język niemiecki, stopień 2;2021-04-01;2021-06-30),(Język niemiecki, stopień 3;2021-07-01;2021-07-31),(Język hiszpański, stopień 1;2021-02-01;2021-05-31),(Język hiszpański, stopień 2;2021-09-01;2021-11-30)
-- (1 row)