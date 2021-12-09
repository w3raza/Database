UNION --pokaz duplikaty

Operator UNION. --laczy bez powtorek

SELECT 'W' AS "Typ", nazwisko, imie, nazwa 
FROM lab04.wykladowca W 
JOIN lab04.uczestnik_organizacja UO USING ( id_wykladowca )
JOIN lab04.organizacja O USING (id_organizacja)
WHERE O.strona_www = 'www.agh.edu.pl'
UNION
SELECT 'U' AS "Typ", nazwisko, imie, nazwa 
FROM lab04.uczestnik W 
JOIN lab04.uczestnik_organizacja UO USING ( id_uczestnik )
JOIN lab04.organizacja O USING (id_organizacja)
WHERE O.strona_www = 'www.agh.edu.pl';

Operator INTERSECT. --czesc wspolna

SELECT nazwisko, imie 
FROM lab04.wykladowca W 
JOIN lab04.uczestnik_organizacja UO USING ( id_wykladowca )
JOIN lab04.organizacja O USING (id_organizacja)
WHERE O.strona_www = 'www.uj.edu.pl'
INTERSECT
SELECT nazwisko, imie 
FROM lab04.wykladowca W 
JOIN lab04.uczestnik_organizacja UO USING ( id_wykladowca )
JOIN lab04.organizacja O USING (id_organizacja)
WHERE O.strona_www = 'www.agh.edu.pl';

Operator EXCEPT. --bez wspolnych

SELECT nazwisko, imie FROM lab04.wykladowca W 
JOIN lab04.uczestnik_organizacja UO USING ( id_wykladowca )
JOIN lab04.organizacja O USING (id_organizacja)
WHERE O.strona_www = 'www.uj.edu.pl'
EXCEPT
SELECT nazwisko, imie 
FROM lab04.wykladowca W 
JOIN lab04.uczestnik_organizacja UO USING ( id_wykladowca )
JOIN lab04.organizacja O USING (id_organizacja)
WHERE O.strona_www = 'www.agh.edu.pl';

--Podzapytania: zawsze nawiasy okragle

SELECT U.nazwisko, U.imie, SuQu.id, SuQu.wynik FROM
(SELECT id_uczest id, sum(oplata) wynik   
FROM lab04.uczest_kurs GROUP BY id_uczest) SuQu
JOIN lab04.uczestnik U ON suqu.id= U.id_uczestnik
ORDER BY suqu.wynik DESC;

SELECT nazwisko, imie FROM lab04.uczestnik 
WHERE id_uczestnik IN 
( SELECT id_uczestnik FROM lab04.uczestnik_organizacja 
WHERE id_organizacja = 1 )ORDER BY 1,2;

SELECT (SELECT SUM(oplata) FROM lab04.uczest_kurs) razem, --oczekujemy jakiejs wartosci skalarnej
(SELECT COUNT(oplata) FROM lab04.uczest_kurs) ilosc, 
(SELECT AVG(oplata) FROM lab04.uczest_kurs) srednia;


--przykład podzapytania skorelowanego 

SELECT KO.opis,( SELECT COUNT(*) 
FROM lab04.wykladowca W 
JOIN lab04.wykl_kurs WK 
ON wk.id_wykl = W.id_wykladowca
WHERE WK.id_kurs=KU.id_kurs ) 
AS ilosc_wykladowcyFROM lab04.kurs KU 
JOIN lab04.kurs_opis KO ON KU.id_nazwa = KO.id_kurs;

Operator ALL --wszytskie zgody

SELECT UO.id_organizacja FROM lab04.uczestnik UC  
JOIN lab04.uczestnik_organizacja UO USING(id_uczestnik)
WHERE UO.id_organizacja 
=ALL (SELECT id_organizacja  FROM lab04.organizacja O 
WHERE UO.id_organizacja = O.id_organizacja);

Operator ANY -- chociaz raz calosc jest prawda

SELECT u.imie, u.nazwisko FROM uczestnik u
WHERE u.id_uczestnik = ANY 
( SELECT id_uczest FROM uczest_kurs )
ORDER BY 2 ;

Operator EXISTS i NOT EXISTS --stwierdaja czy prawda jest wynik podzapytania

SELECT ko.opis FROM lab04.kurs KU 
JOIN lab04.kurs_opis KO ON KU.id_nazwa= ko.id_kurs
WHERE EXISTS ( SELECT 1 FROM lab04.wykl_kurs WK 
WHERE wk.id_kurs = ku.id_kurs );

SELECT ko.opis FROM lab04.kurs KU 
JOIN lab04.kurs_opis KO ON KU.id_nazwa = ko.id_kurs
WHERE NOT EXISTS 
( SELECT 1 FROM lab04.wykl_kurs WK WHERE wk.id_kurs = ku.id_kurs );

--PERSPEKTYWA

CREATE VIEW vw_kurs_wykladowca (opis, nazwisko,imie)
AS
SELECT ko.opis, wy.nazwisko, wy.imie FROM kurs KU 
JOIN kurs_opis KO ON KU.id_kurs = KO.id_kurs
JOIN wykl_kurs WK ON WK.id_kurs = ku.id_kurs 
AND WK.id_grupa = ku.id_grupa
JOIN wykladowca WY ON wy.id_wykladowca = wk.id_wykl;