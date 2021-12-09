-- 1. Lista z nazwiskami i imionami uczestników z kolumną o wartościach 
-- ('duża', 'średnia', 'mała', 'brak'). Wartości tej kolumny zależne od kolumny obecnosc.
-- ('duża', 'średnia', 'mała', 'brak'). Wartości tej kolumny zależne od kolumny obecnosc.
-- duża - >= 90% pełnej obecności
-- średnia >= 50% i < 90%
-- mała < 50%
-- brak - nie uczestniczył.

-- 0 - nieobecny
-- 1 - obecny
-- 2 - spóźniony
-- 3 - usprawiedliwiony

WITH frekwencja_cte AS (
SELECT uczestnik.nazwisko, uczestnik.imie, AVG(CASE
WHEN aktywnosc.obecnosc = 1 OR aktywnosc.obecnosc = 2 THEN 1 ELSE 0 END) AS frekwencja
FROM lab04.uczestnik
LEFT JOIN lab04.aktywnosc ON aktywnosc.id_uczestnik = uczestnik.id_uczestnik
GROUP BY uczestnik.id_uczestnik
)

SELECT nazwisko, imie, CASE
WHEN frekwencja >=0.9 THEN 'duza'
WHEN frekwencja >=0.5 AND frekwencja <0.9 THEN 'srednia'
WHEN frekwencja <0.5 AND frekwencja >0 THEN 'mala'
ELSE 'brak' END AS "frekwencja"
FROM frekwencja_cte;

--    nazwisko   |   imie    | frekwencja 
-- --------------+-----------+------------
--  Hołownia     | Mateusz   | brak
--  Straszewski  | Józef     | duza
--  Iwanowicz    | Grzegorz  | duza
--  Flisikowski  | Jan       | srednia
--  Kotulski     | Marek     | duza
--  Niedziałek   | Marian    | brak
--  Łaski        | Michał    | duza
--  Bukowiecki   | Ryszard   | srednia
--  Całus        | Łukasz    | duza
--  Płochocki    | Piotr     | srednia
--  Barnaś       | Jerzy     | brak
--  Nawara       | Kazimierz | brak
--  Dwojak       | Marcin    | brak
--  Rafalski     | Robert    | brak
--  Stachera     | Tadeusz   | brak
--  Matuszczak   | Rafał     | brak
--  Kołodziejek  | Zbigniew  | srednia
--  Wolf         | Jacek     | brak
--  Gzik         | Adam      | brak
--  Chrobok      | Mirosław  | brak
--  Stachyra     | Krzysztof | brak
--  Sosin        | Tomasz    | brak
--  Sielicki     | Dariusz   | brak
--  Kolczyński   | Janusz    | brak
--  Olech        | Andrzej   | srednia
--  Szcześniak   | Mariusz   | brak
--  Kęski        | Wojciech  | brak
--  Radziszewski | Henryk    | srednia
--  Sztuka       | Stanisław | srednia
--  Głowala      | Paweł     | srednia
-- (30 rows)

-- 2. Lista z nazwiskami i imionami wykładowców z kolumną o wartościach ('poniżej limitu', 'limit', 'powyżej limitu' )
-- Wartości tej kolumny zależne od ilości uczestników na kursach danego wykładowcy.
-- Np. limit to średnia ilość na kurs zaokrąglona do najbliższej liczby całkowitej.

WITH ilosc_uczestnikow_wykladowcy AS (
SELECT id_wykladowca, CASE
WHEN SUM(ilosc_uczestnikow_na_kursie.ilosc_uczestnikow) IS NULL THEN 0
ELSE SUM(ilosc_uczestnikow_na_kursie.ilosc_uczestnikow) END AS ilosc_uczestnikow
FROM lab04.wykladowca
LEFT JOIN lab04.wykl_kurs ON wykl_kurs.id_wykl = wykladowca.id_wykladowca
LEFT JOIN (SELECT kurs.id_kurs, COUNT(uczest_kurs.id_uczest) AS ilosc_uczestnikow
FROM lab04.kurs
JOIN lab04.uczest_kurs ON uczest_kurs.id_kurs = kurs.id_kurs
GROUP BY kurs.id_kurs) AS ilosc_uczestnikow_na_kursie on ilosc_uczestnikow_na_kursie.id_kurs = wykl_kurs.id_kurs
GROUP BY id_wykladowca
),
srednia_ilosc_uczestnikow_wykladowcy AS (
SELECT ROUND(AVG(ilosc_uczestnikow_wykladowcy.ilosc_uczestnikow)) as srednia
FROM ilosc_uczestnikow_wykladowcy
)

SELECT wykladowca.nazwisko, wykladowca.imie, CASE
WHEN ilosc_uczestnikow_wykladowcy.ilosc_uczestnikow > srednia_ilosc_uczestnikow_wykladowcy.srednia THEN 'powyżej limitu'
WHEN ilosc_uczestnikow_wykladowcy.ilosc_uczestnikow = srednia_ilosc_uczestnikow_wykladowcy.srednia THEN 'limit'
ELSE 'poniżej limitu' END AS "limit"
FROM lab04.wykladowca
JOIN ilosc_uczestnikow_wykladowcy ON ilosc_uczestnikow_wykladowcy.id_wykladowca = wykladowca.id_wykladowca
, srednia_ilosc_uczestnikow_wykladowcy;

--   nazwisko   |    imie    |     limit      
-- -------------+------------+----------------
--  Szymczak    | Marcin     | powyżej limitu
--  Baranowska  | Joanna     | limit
--  Szczepański | Maciej     | powyżej limitu
--  Wróbel      | Czesław    | powyżej limitu
--  Górska      | Grażyna    | powyżej limitu
--  Krawczyk    | Wanda      | poniżej limitu
--  Urbańska    | Renata     | poniżej limitu
--  Tomaszewska | Wiesława   | poniżej limitu
--  Baranowska  | Bożena     | poniżej limitu
--  Malinowska  | Ewelina    | poniżej limitu
--  Krajewska   | Anna       | powyżej limitu
--  Zając       | Mieczysław | poniżej limitu
--  Przybylski  | Wiesław    | poniżej limitu
--  Tomaszewska | Dorota     | poniżej limitu
--  Wróblewski  | Jerzy      | poniżej limitu
-- (15 rows)

-- 3. Korzystając z CTE pokazać średnią ilość uczestników na kursie. Nie korzystamy z agregatu AVG.

WITH ilosc_uczestnikow_na_kursach 
AS ( SELECT count(*) as ilosc FROM lab04.uczest_kurs),
ilosc_kursow as (SELECT count(*) as ilosc FROM lab04.kurs)

SELECT(ilosc_uczestnikow_na_kursach.ilosc::float / ilosc_kursow.ilosc) AS "średnia" FROM ilosc_uczestnikow_na_kursach, ilosc_kursow;

--  średnia
-- -------------------------------------
--                     6.72727272727273
-- (1 row)
