
CREATE TABLE lab02.Wykladowca (
                id_wykladowca INTEGER NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                CONSTRAINT wykladowca_pk PRIMARY KEY (id_wykladowca)
);


CREATE TABLE lab02.Kurs_opis (
                id_kurs INTEGER NOT NULL,
                opis VARCHAR(200) NOT NULL,
                CONSTRAINT kurs_opis_pk PRIMARY KEY (id_kurs)
);


CREATE TABLE lab02.Kurs (
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs_nazwa INTEGER NOT NULL,
                CONSTRAINT kurs_pk PRIMARY KEY (id_kurs, id_grupa)
);


CREATE TABLE lab02.wykl_kurs (
                id_grupa INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_wykl INTEGER NOT NULL
);


CREATE TABLE lab02.uczestnik (
                id_uczestnik INTEGER NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                CONSTRAINT uczestnik_pk PRIMARY KEY (id_uczestnik)
);


CREATE TABLE lab02.uczestnik_kurs (
                id_uczest INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


ALTER TABLE lab02.wykl_kurs ADD CONSTRAINT wykladowca_wykl_kurs_fk
FOREIGN KEY (id_wykl)
REFERENCES lab02.Wykladowca (id_wykladowca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab02.Kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs)
REFERENCES lab02.Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab02.uczestnik_kurs ADD CONSTRAINT kurs_uczestnik_kurs_fk
FOREIGN KEY (id_grupa, id_kurs)
REFERENCES lab02.Kurs (id_grupa, id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab02.wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES lab02.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab02.uczestnik_kurs ADD CONSTRAINT uczestnik_uczestnik_kurs_fk
FOREIGN KEY (id_uczest)
REFERENCES lab02.uczestnik (id_uczestnik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
