
CREATE TABLE Wykladowca (
                id_wykladowcy INT AUTO_INCREMENT NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_wykladowcy)
);


CREATE TABLE Kurs_opis (
                id_kurs INT AUTO_INCREMENT NOT NULL,
                opis varchar VARCHAR(200) NOT NULL,
                PRIMARY KEY (id_kurs)
);


CREATE TABLE Kurs (
                id_kurs INT NOT NULL,
                id_grupa INT NOT NULL,
                id_kurs_nazwa INT NOT NULL,
                PRIMARY KEY (id_kurs, id_grupa)
);


CREATE TABLE wykl_kurs (
                id_wykl INT NOT NULL,
                id_kurs INT NOT NULL,
                id_grupa INT NOT NULL
);


CREATE TABLE Uczestnik (
                id_uczestnik INT AUTO_INCREMENT NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_uczestnik)
);


CREATE TABLE uczest_kurs (
                id_uczestnik INT NOT NULL,
                id_kurs INT NOT NULL,
                id_grupa INT NOT NULL
);


ALTER TABLE wykl_kurs ADD CONSTRAINT wykladowca_wykl_kurs_fk
FOREIGN KEY (id_wykl)
REFERENCES Wykladowca (id_wykladowcy)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs)
REFERENCES Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_grupa, id_kurs)
REFERENCES Kurs (id_grupa, id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE uczest_kurs ADD CONSTRAINT kurs_uczest_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE uczest_kurs ADD CONSTRAINT uczestnik_uczest_kurs_fk
FOREIGN KEY (id_uczestnik)
REFERENCES Uczestnik (id_uczestnik)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- INSERTY

--skrypt 1

alter table kurs add primary key (id_kurs, id_grupa) ;
alter table uczestnik add primary key (id_uczestnik) ;

insert into uczestnik ( id_uczestnik, nazwisko, imie ) values 
( 1, 'Flisikowski', 'Jan'),
( 2, 'Olech', 'Andrzej'       ),
( 3, 'Plochocki', 'Piotr'    ),
( 4, 'Stachyra', 'Krzysztof' ),
( 5, 'Sztuka', 'Stanislaw'   ),
( 6, 'Sosin', 'Tomasz'       ),
( 7, 'Glowala', 'Pawel'      ),
( 8, 'Straszewski', 'Jozef'  ),
( 9, 'Dwojak', 'Marcin'      ),
(10, 'Kotulski', 'Marek'    ),
(11, 'Laski', 'Michal'       ),
(12, 'Iwanowicz', 'Grzegorz' ),
(13, 'Barnal', 'Jerzy'       ),
(14, 'Stachera', 'Tadeusz'   ),
(15, 'Gzik', 'Adam'          ),
(16, 'Calus', 'Lukasz'       ),
(17, 'Kolodziejek', 'Zbigniew'),
(18, 'Bukowiecki', 'Ryszard' ),
(19, 'Sielicki', 'Dariusz'   ),
(20, 'Radziszewski', 'Henryk'),
(21, 'Szczelniak', 'Mariusz' ),
(22, 'Nawara', 'Kazimierz'   ),
(23, 'Keski', 'Wojciech'     ),
(24, 'Rafalski', 'Robert'    ),
(25, 'Holownia', 'Mateusz'   ),
(26, 'Niedzialek', 'Marian'  ),
(27, 'Matuszczak', 'Rafal'   ),
(28, 'Wolf', 'Jacek'         ),
(29, 'Kolczynski', 'Janusz'  ),
(30, 'Chrobok', 'Miroslaw'   )  ;

insert into kurs ( id_kurs, id_grupa, id_kurs_nazwa, termin ) values
( 1, 1, 1, '1.01.2017-31.03.2017'),
( 2, 2, 1, '1.01.2017-31.03.2017'),
( 3, 1, 2, '1.04.2017-30.06.2017'),
( 4, 1, 3, '1.08.2017-10.10.2017'),
( 5, 1, 4, '1.11.2017-23.12.2017'),
( 6, 1, 6, '1.01.2017-31.03.2017'),
( 7, 2, 6, '1.01.2017-31.03.2017'),
( 8, 1, 7, '1.04.2017-30.06.2017'),
( 9, 1, 8, '1.07.2017-31.07.2017'),
(10, 1, 10, '1.02.2017-31.05.2017'),
(11, 1, 11, '1.09.2017-30.11.2017') ; 

-- skrypt 2
create table uczest_kurs ( id_uczest int, id_kurs int , id_grupa int) ;
alter table uczest_kurs add primary key (id_uczest, id_kurs, id_grupa) ;
alter table uczest_kurs add foreign key (id_uczest) references uczestnik ( id_uczestnik) ;
alter table uczest_kurs add foreign key (id_kurs, id_grupa) references kurs ( id_kurs, id_grupa) ;
insert into uczest_kurs ( id_kurs, id_grupa, id_uczest ) values
-- kurs 1 - angielski 1 gr 1
( 1, 1,  1 ),
( 1, 1,  3 ),
( 1, 1,  5 ),
( 1, 1,  7 ),
( 1, 1,  8 ),
( 1, 1, 10 ),
( 1, 1, 11 ),
( 1, 1, 12 ),
-- kurs 2 - angielski 1 gr 2
( 2, 2,  2 ),
( 2, 2, 16 ),
( 2, 2, 17 ),
( 2, 2, 18 ),
( 2, 2, 20 ),
-- kurs 3 - angielski 2 gr 1
( 3, 1,  1 ),
( 3, 1,  2 ),
( 3, 1,  3 ),
( 3, 1,  5 ),
( 3, 1,  7 ),
( 3, 1, 17 ),
( 3, 1, 18 ),
( 3, 1, 20 ),
-- kurs 4 - angielski 3 gr 1
( 4, 1,  1 ),
( 4, 1,  2 ),
( 4, 1,  3 ),
( 4, 1,  5 ),
( 4, 1, 21 ),
( 4, 1, 22 ),
( 4, 1, 25 ),
-- kurs 5 - angielski 4 gr 1
( 5, 1,  1 ),
( 5, 1,  2 ),
( 5, 1,  3 ),
( 5, 1,  5 ),
( 5, 1, 21 ),
( 5, 1, 22 ),
-- kurs 6 - niemiecki 1 gr 1
( 6, 1,  8 ),
( 6, 1,  9 ),
( 6, 1, 13 ),
( 6, 1, 15 ),
( 6, 1, 19 ),
( 6, 1, 24 ),
( 6, 1, 27 ),
-- kurs 7 - niemiecki 1 gr 2
( 7, 2, 11 ),
( 7, 2, 17 ),
( 7, 2, 18 ),
( 7, 2, 23 ),
( 7, 2, 25 ),
( 7, 2, 28 ),
( 7, 2, 30 ),
-- kurs 8 - niemiecki 2 gr 1
( 8, 1,  8 ),
( 8, 1,  9 ),
( 8, 1, 13 ),
( 8, 1, 15 ),
( 8, 1, 19 ),
( 8, 1, 24 ),
( 8, 1, 27 ),
-- kurs 9 - niemiecki 3 gr 1
( 9, 1,  8 ),
( 9, 1,  9 ),
( 9, 1, 13 ),
( 9, 1, 24 ),
( 9, 1, 27 ),
-- kurs 10 - hiszpanski 1 gr 1
(10, 1,  6 ),
(10, 1, 16 ),
(10, 1, 18 ),
(10, 1, 22 ),
(10, 1, 24 ),
(10, 1, 29 ),
(10, 1, 30 ),
-- kurs 11 - hiszpanski 2 gr 1
(11, 1,  6 ),
(11, 1, 16 ),
(11, 1, 18 ),
(11, 1, 22 ),
(11, 1, 24 ),
(11, 1, 29 ),
(11, 1, 30 ) ; 

--skrypt 4 
create table kurs_opis ( id_kurs int, opis varchar(30) ) ;
alter table kurs_opis add primary key (id_kurs) ;

insert into kurs_opis ( id_kurs, opis ) values
( 1, 'Jezyk angielski, stopien 1'),
( 2, 'Jezyk angielski, stopien 2'),
( 3, 'Jezyk angielski, stopien 3'), 
( 4, 'Jezyk angielski, stopien 4'),
( 5, 'Jezyk angielski, stopien 5'),
( 6, 'Jezyk niemiecki, stopien 1'),
( 7, 'Jezyk niemiecki, stopien 2'),
( 8, 'Jezyk niemiecki, stopien 3'),
( 9, 'Jezyk niemiecki, stopien 4'),
(10, 'Jezyk hiszpanski, stopien 1'),
(11, 'Jezyk hiszpanski, stopien 2'),
(12, 'Jezyk hiszpanski, stopien 3') ;

--skrypt 7

create table wykladowca ( id_wykladowca int, nazwisko varchar(30), imie varchar(30) ) ;
create table wykl_kurs ( id_wykl int, id_kurs int , id_grupa int) ;

alter table wykladowca add primary key (id_wykladowca) ;
alter table wykl_kurs add primary key (id_wykl, id_kurs, id_grupa) ;
--
alter table wykl_kurs add foreign key (id_kurs, id_grupa) references kurs ( id_kurs, id_grupa) ;
alter table wykl_kurs add foreign key (id_wykl) references wykladowca ( id_wykladowca) ;
--
insert into wykladowca ( id_wykladowca, imie, nazwisko ) values 
( 1, 'Marcin','Szymczak'),
( 2, 'Joanna','Baranowska'),
( 3, 'Maciej','Szczepalski'),
( 4, 'Czeslaw','Wrobel'),
( 5, 'Grazyna','Gorska'),
( 6, 'Wanda','Krawczyk'),
( 7, 'Renata','Urbalska'),
( 8, 'Wieslawa','Tomaszewska'),
( 9, 'Bozena','Baranowska'),
(10, 'Ewelina','Malinowska'),
(11, 'Anna','Krajewska'),
(12, 'Mieczyslaw','Zajac'),
(13, 'Wieslaw','Przybylski'),
(14, 'Dorota','Tomaszewska'),
(15, 'Jerzy','Wroblewski') ;
--
insert into wykl_kurs ( id_kurs, id_grupa, id_wykl ) values
( 1, 1, 1 ),
( 2, 2, 2 ),
( 3, 1, 1 ),
( 4, 1, 1 ),
( 5, 1, 3 ),
( 6, 1, 4 ),
( 7, 2, 5 ),
( 8, 1, 4 ),
( 9, 1, 4 ),
(10, 1, 11 ),
(11, 1, 11 ) ; 