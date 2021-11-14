-- 1
SELECT  opis, data_rozpoczecia, data_zakonczenia, nazwisko, imie, email 
FROM lab04.kurs KU 
JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs
LEFT OUTER JOIN lab04.wykl_kurs WK ON wk.id_kurs = ku.id_kurs
LEFT OUTER JOIN lab04.wykladowca WY ON WY.id_wykladowca = wk.id_wykl;

SELECT  opis, data_rozpoczecia, data_zakonczenia, nazwisko, imie, email 
FROM lab04.kurs KU 
JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs 
RIGHT OUTER JOIN lab04.wykl_kurs WK ON wk.id_kurs = ku.id_kurs 
RIGHT OUTER JOIN lab04.wykladowca WY ON WY.id_wykladowca = wk.id_wykl; 

SELECT  opis, data_rozpoczecia, data_zakonczenia, nazwisko, imie, email 
FROM lab04.kurs KU 
JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs 
FULL OUTER JOIN lab04.wykl_kurs WK ON wk.id_kurs = ku.id_kurs 
FULL OUTER JOIN lab04.wykladowca WY ON WY.id_wykladowca = wk.id_wykl;

--             opis             | data_rozpoczecia | data_zakonczenia |  nazwisko   |  imie   |         email         
-- -----------------------------+------------------+------------------+-------------+---------+-----------------------
--  Język angielski, stopień 1  | 2021-01-01       | 2021-03-31       | Szymczak    | Marcin  | 
--  Język angielski, stopień 1  | 2021-01-01       | 2021-03-31       | Baranowska  | Joanna  | Baranowska@agh.edu.pl
--  Język angielski, stopień 2  | 2021-04-01       | 2021-06-30       | Szymczak    | Marcin  | 
--  Język angielski, stopień 3  | 2021-08-01       | 2021-10-10       | Szymczak    | Marcin  | 
--  Język angielski, stopień 4  | 2021-11-01       | 2021-12-23       | Szczepański | Maciej  | 
--  Język niemiecki, stopień 1  | 2021-01-01       | 2021-03-31       | Wróbel      | Czesław | 
--  Język niemiecki, stopień 1  | 2021-01-01       | 2021-03-31       | Górska      | Grażyna | 
--  Język niemiecki, stopień 2  | 2021-04-01       | 2021-06-30       | Wróbel      | Czesław | 
--  Język niemiecki, stopień 3  | 2021-07-01       | 2021-07-31       | Wróbel      | Czesław | 
--  Język hiszpański, stopień 1 | 2021-02-01       | 2021-05-31       | Krajewska   | Anna    | 
--  Język hiszpański, stopień 2 | 2021-09-01       | 2021-11-30       | Krajewska   | Anna    | 

-- 2

SELECT ko.id_kurs, MIN(ocena) AS "min", MAX(ocena) AS "max", AVG(ocena) AS "Average"
FROM lab04.kurs KU
JOIN lab04.uczest_kurs UK USING (id_kurs)
JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs
GROUP BY ko.id_kurs ORDER BY ko.id_kurs;

--  id_kurs | min  | max  |      Average       
-- ---------+------+------+--------------------
--        1 | 3.00 | 5.00 | 3.7692307692307692
--        2 | 3.00 | 5.00 | 3.8750000000000000
--        3 | 3.00 | 5.00 | 4.0000000000000000
--        4 | 3.00 | 5.00 | 3.8333333333333333
--        6 | 3.00 | 5.00 | 3.6428571428571429
--        7 | 3.00 | 5.00 | 3.5714285714285714
--        8 | 4.00 | 5.00 | 4.4000000000000000
--       10 | 3.00 | 5.00 | 3.8571428571428571
--       11 | 3.00 | 5.00 | 3.8571428571428571

-- 3
SELECT wy.imie, wy.nazwisko, wy.email, COUNT(*)
FROM lab04.wykladowca WY 
JOIN lab04.wykl_kurs WK ON wy.id_wykladowca = wk.id_wykl
JOIN lab04.uczest_kurs UK USING(id_kurs)
JOIN lab04.kurs KU USING(id_kurs) 
JOIN lab04.uczestnik UC ON uk.id_uczest = uc.id_uczestnik
GROUP BY (wy.id_wykladowca) ORDER BY COUNT(*) DESC;

--   imie   |  nazwisko   |         email         | count 
-- ---------+-------------+-----------------------+-------
--  Marcin  | Szymczak    |                       |    23
--  Czesław | Wróbel      |                       |    19
--  Anna    | Krajewska   |                       |    14
--  Grażyna | Górska      |                       |     7
--  Maciej  | Szczepański |                       |     6
--  Joanna  | Baranowska  | Baranowska@agh.edu.pl |     5