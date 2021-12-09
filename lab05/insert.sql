insert into  lab04.organizacja( id_organizacja, nazwa, strona_www ) values
(1, 'Uniwersytet Jagielloński', 'www.uj.edu.pl'),
(2, 'Akademia Górniczo-Hutnicza', 'www.agh.edu.pl');

--
insert into lab04.uczestnik_organizacja ( id_organizacja, id_uczestnik)
VALUES( 1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),(1, 7),(1, 8),(1, 9)
,(1,10),(1, 11),(1, 12),(1, 13),(1, 14)
,(2, 15),(2, 16),(2, 17),(2, 18),(2, 19),(2, 20),(2, 21),(2, 22)
,(2, 23),(2, 24),(2, 25),(2, 26),(2, 27),(2, 28)
,(2, 3),(2, 8),(1, 19),(1, 21),(1, 25);

--
insert into lab04.uczestnik_organizacja ( id_organizacja, id_wykladowca)
VALUES( 1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6)
,(2, 7),(2, 8),(2, 9),(2, 10),(2, 11),(2, 12),(2, 13)
,(2, 5);