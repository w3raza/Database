ALTER TABLE "u9zaczyk"."lab03"."kurs" DROP COLUMN termin;

ALTER TABLE "u9zaczyk"."lab03"."uczestnik_kurs" DROP COLUMN id_grupa;

ALTER TABLE "u9zaczyk"."lab03"."wykl_kurs" DROP COLUMN id_grupa;

ALTER TABLE "u9zaczyk"."lab03"."kurs" ADD COLUMN "termin_p" DATE NOT NULL;

ALTER TABLE "u9zaczyk"."lab03"."kurs" ADD COLUMN "termin_k" DATE NOT NULL;

ALTER TABLE ONLY "u9zaczyk"."lab03"."kurs" ALTER COLUMN "id_nazwa" TYPE INTEGER, ALTER COLUMN "id_nazwa" SET NOT NULL;

ALTER TABLE "u9zaczyk"."lab03"."uczestnik" ADD COLUMN "adres" VARCHAR(200);

ALTER TABLE "u9zaczyk"."lab03"."uczestnik" ADD COLUMN "kod_pocztowy" VARCHAR(6);

ALTER TABLE "u9zaczyk"."lab03"."uczestnik" ADD COLUMN "miejscowosc" VARCHAR(60);

--polecenie skryptu
SELECT uczestnik.nazwisko, uczestnik.imie, kurs_opis.opis, kurs.id_kurs, kurs.id_grupa
FROM lab03.kurs, lab03.uczestnik_kurs, lab03.uczestnik, lab03.kurs_opis
WHERE kurs.id_kurs = uczestnik_kurs.id_kurs and  
      uczestnik.id_uczestnik = uczestnik_kurs.id_uczest and
      kurs.id_kurs_nazwa = kurs_opis.id_kurs ;