-- ecpg program.pqc
-- gcc -g -I/usr/include/postgresql program.c -o program -lecpg

-- sqlca.sqlcode -ujemna wartość błąd poważny, zero udane wywołanie, 100 niemożność znalezienia danych
-- sqlca.sqlerrm.sqlerrmc -tekstkomunikatu o błędzie
-- sqlca.sqlerrd[2] -liczba przetworzonych wierszy
-- sqlca.sqlwarn[0] -"W", gdy dane zostały pobrane, lecz nie udało się ich poprawnie przekazać do programu

-- 1. Napisać program pgc wypisujący na konsoli wartości funkcji informacyjnych typu current_. https://www.postgresql.org/docs/9.1/functions-info.html 

-- 2. Napisać program pgc poprawiający wartości email dla zadanego uczestnika (UPDATE). Id uczestnika ma być parametrem.

-- 3. Napisać program pgc wypisujący na konsoli listę uczestników zadanego kursu (nazwisko, imię, opis_kursu). Id kursu ma być parametrem.