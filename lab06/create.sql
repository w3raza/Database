-- zmiany w strukturze bazy danych
-- obecny 1
-- nieobecny 2
-- nieobecny ale usprawiedliwiony 3
------------------------------------------------------------------------------------

CREATE TABLE lab04.zajecia (
                "id_zajecia" INTEGER NOT NULL,
                "id_kurs" INTEGER NOT NULL,
                "data" DATE,
                CONSTRAINT "zajecia_pk" PRIMARY KEY ("id_zajecia")
);

CREATE TABLE lab04.aktywnosc (
                "id_zajecia" INTEGER NOT NULL,
                "id_uczestnik" INTEGER NOT NULL,
                "obecnosc" INTEGER DEFAULT 0 NOT NULL,
		"punkty" INTEGER
);



ALTER TABLE lab04.zajecia ADD CONSTRAINT "kurs_zajecia_fk"
FOREIGN KEY ("id_kurs")
REFERENCES lab04.kurs ("id_kurs")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab04.aktywnosc ADD CONSTRAINT "uczestnik_aktywnosc_fk"
FOREIGN KEY ("id_uczestnik")
REFERENCES lab04.uczestnik ("id_uczestnik")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab04.aktywnosc ADD CONSTRAINT "zajecia_aktywnosc_fk"
FOREIGN KEY ("id_zajecia")
REFERENCES lab04.zajecia ("id_zajecia")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
-------------------

-----------------------------------------------------

-- DANE

WITH RECURSIVE add_zajecia (id_kurs, n) AS (
     SELECT id_kurs, 0 FROM lab04.kurs 
     UNION ALL
     SELECT id_kurs, n+1 FROM add_zajecia WHERE n<10 )
INSERT INTO lab04.zajecia ( id_zajecia, id_kurs, data) SELECT n+1, id_kurs, date '2021-01-02' + n*7 * INTERVAL '1 day' FROM add_zajecia WHERE id_kurs IN (1);

WITH RECURSIVE add_zajecia (id_kurs, n) AS (
     SELECT id_kurs, 0 FROM lab04.kurs 
     UNION ALL
     SELECT id_kurs, n+1 FROM add_zajecia WHERE n<10 )
INSERT INTO lab04.zajecia ( id_zajecia, id_kurs, data) SELECT n+12, id_kurs, date '2021-01-03' + n*7 * INTERVAL '1 day' FROM add_zajecia WHERE id_kurs IN (2);

WITH RECURSIVE add_zajecia (id_kurs, n) AS (
     SELECT id_kurs, 0 FROM lab04.kurs 
     UNION ALL
     SELECT id_kurs, n+1 FROM add_zajecia WHERE n<10 )
INSERT INTO lab04.zajecia ( id_zajecia, id_kurs, data) SELECT n+23, id_kurs, date '2021-01-05' + n*7 * INTERVAL '1 day' FROM add_zajecia WHERE id_kurs IN (3);


with ser(ob, pkt, i) as (
  select round(random()*100), round(random()*100), generate_series(1,33)
),
ran(ob, pkt, i) as (
  select
    case 
      when ob between 0 and 5 then 2
      when ob between 6 and 11 then 3
      when ob between 12 and 87 then 1
      else 0
    end
    ,pkt,i
  from ser
)
INSERT INTO lab04.aktywnosc (id_zajecia, id_uczestnik, obecnosc, punkty) 
SELECT id_zajecia, uczkur.id_uczest, ob, pkt
FROM lab04.zajecia za JOIN lab04.uczest_kurs uczkur USING(id_kurs)
JOIN ran ON ran.i = za.id_zajecia
ORDER BY id_zajecia, uczkur.id_uczest;

--------------------------------------------------------

