-- 1.Lista uczestników kursu niemieckiego lub angielskiego.

SELECT U.nazwisko, U.imie FROM lab04.uczestnik U 
JOIN lab04.uczest_kurs UK ON U.id_uczestnik = UK.id_uczest
JOIN lab04.kurs K USING (id_kurs)
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
WHERE KO.opis like 'Język angielski%'
UNION
SELECT U.nazwisko, U.imie FROM lab04.uczestnik U 
JOIN lab04.uczest_kurs UK ON U.id_uczestnik = UK.id_uczest
JOIN lab04.kurs K USING (id_kurs)
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
WHERE KO.opis like 'Język niemiecki%';

--    nazwisko   |   imie    
-- --------------+-----------
--  Barnaś       | Jerzy
--  Bukowiecki   | Ryszard
--  Całus        | Łukasz
--  Chrobok      | Mirosław
--  Dwojak       | Marcin
--  Flisikowski  | Jan
--  Głowala      | Paweł
--  Gzik         | Adam
--  Hołownia     | Mateusz
--  Iwanowicz    | Grzegorz
--  Kęski        | Wojciech
--  Kołodziejek  | Zbigniew
--  Kotulski     | Marek
--  Łaski        | Michał
--  Matuszczak   | Rafał
--  Nawara       | Kazimierz
--  Olech        | Andrzej
--  Płochocki    | Piotr
--  Radziszewski | Henryk
--  Rafalski     | Robert
--  Sielicki     | Dariusz
--  Straszewski  | Józef
--  Szcześniak   | Mariusz
--  Sztuka       | Stanisław
--  Wolf         | Jacek
-- (25 rows)

-- 2.Lista uczestników kursu niemieckiego i angielskiego.

SELECT U.nazwisko, U.imie FROM lab04.uczestnik U 
JOIN lab04.uczest_kurs UK ON U.id_uczestnik = UK.id_uczest
JOIN lab04.kurs K USING (id_kurs)
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
WHERE KO.opis like 'Język angielski%'
INTERSECT
SELECT U.nazwisko, U.imie FROM lab04.uczestnik U 
JOIN lab04.uczest_kurs UK ON U.id_uczestnik = UK.id_uczest
JOIN lab04.kurs K USING (id_kurs)
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
WHERE KO.opis like 'Język niemiecki%';

--   nazwisko   |   imie   
-- -------------+----------
--  Hołownia    | Mateusz
--  Kołodziejek | Zbigniew
--  Bukowiecki  | Ryszard
--  Straszewski | Józef
--  Łaski       | Michał
-- (5 rows)

-- 3.Lista uczestników kursu niemieckiego z wyłączeniem uczestników angielskiego.

SELECT U.nazwisko, U.imie FROM lab04.uczestnik U 
JOIN lab04.uczest_kurs UK ON U.id_uczestnik = UK.id_uczest
JOIN lab04.kurs K USING (id_kurs)
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
WHERE KO.opis like 'Język angielski%'
EXCEPT
SELECT U.nazwisko, U.imie FROM lab04.uczestnik U 
JOIN lab04.uczest_kurs UK ON U.id_uczestnik = UK.id_uczest
JOIN lab04.kurs K USING (id_kurs)
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
WHERE KO.opis like 'Język niemiecki%';

--    nazwisko   |   imie    
-- --------------+-----------
--  Flisikowski  | Jan
--  Iwanowicz    | Grzegorz
--  Całus        | Łukasz
--  Radziszewski | Henryk
--  Olech        | Andrzej
--  Głowala      | Paweł
--  Nawara       | Kazimierz
--  Płochocki    | Piotr
--  Szcześniak   | Mariusz
--  Sztuka       | Stanisław
--  Kotulski     | Marek
-- (11 rows)

-- 4.Listy kursów dla których suma opłat jest większa od zadanej wartości.

SELECT K.id_kurs, KO.opis, SUM(UK.oplata) AS "razem" FROM lab04.kurs K
JOIN lab04.uczest_kurs UK ON K.id_kurs = UK.id_kurs
JOIN lab04.kurs_opis KO ON K.id_nazwa = KO.id_kurs
GROUP BY K.id_kurs, KO.opis HAVING SUM(UK.oplata) > 5000 ORDER BY 1; 

--  id_kurs |            opis             |  razem  
-- ---------+-----------------------------+---------
--        3 | Język angielski, stopień 2  | 5600.00
--        4 | Język angielski, stopień 3  | 5600.00
--        5 | Język angielski, stopień 4  | 5100.00
--       11 | Język hiszpański, stopień 2 | 6300.00
-- (4 rows)

-- 5.Lista wykładowców o największej ilości studentów na kursach.

SELECT wykladowca.imie, wykladowca.nazwisko, COUNT(studenci_wykladowcy.id_uczest) AS ilosc FROM lab04.wykladowca
JOIN (SELECT DISTINCT wykladowca.id_wykladowca, uczest_kurs.id_uczest FROM lab04.wykladowca wykladowca
JOIN lab04.wykl_kurs wykl_kurs ON wykl_kurs.id_wykl = wykladowca.id_wykladowca
JOIN lab04.kurs kurs USING(id_kurs)
JOIN lab04.uczest_kurs uczest_kurs USING(id_kurs)) AS studenci_wykladowcy USING(id_wykladowca)
GROUP BY wykladowca.id_wykladowca  ORDER BY ilosc DESC LIMIT  1;

--   imie  | nazwisko | ilosc 
-- --------+----------+-------
--  Marcin | Szymczak |    15
-- (1 row)


-- 6.Lista studentów o maksymalnej ocenie dla danej organizacji.

SELECT DISTINCT uczestnik.imie, uczestnik.nazwisko, organizacja.nazwa  FROM lab04.uczestnik
JOIN lab04.uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab04.uczestnik_organizacja USING(id_uczestnik)
JOIN lab04.organizacja USING(id_organizacja)
WHERE uczest_kurs.ocena = 5;

--    imie    |  nazwisko   |           nazwa            
-- -----------+-------------+----------------------------
--  Rafał     | Matuszczak  | Akademia Górniczo-Hutnicza
--  Piotr     | Płochocki   | Uniwersytet Jagielloński
--  Dariusz   | Sielicki    | Uniwersytet Jagielloński
--  Mateusz   | Hołownia    | Uniwersytet Jagielloński
--  Stanisław | Sztuka      | Uniwersytet Jagielloński
--  Ryszard   | Bukowiecki  | Akademia Górniczo-Hutnicza
--  Piotr     | Płochocki   | Akademia Górniczo-Hutnicza
--  Dariusz   | Sielicki    | Akademia Górniczo-Hutnicza
--  Mateusz   | Hołownia    | Akademia Górniczo-Hutnicza
--  Kazimierz | Nawara      | Akademia Górniczo-Hutnicza
--  Zbigniew  | Kołodziejek | Akademia Górniczo-Hutnicza
--  Michał    | Łaski       | Uniwersytet Jagielloński
--  Robert    | Rafalski    | Akademia Górniczo-Hutnicza
-- (13 rows)


