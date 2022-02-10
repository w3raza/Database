/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "task3.pqc"
#include <stdio.h>
#include <stdlib.h>

char * dbuser = "u9zaczyk";
char * dbpass  = "9zaczyk";
char * dbhost = "pascal";
char * dbport = "5432";

/* exec sql begin declare section */
         
         
         
         
         
          
           
          
          
         
         
         

#line 10 "task3.pqc"
 char dbname [ 128 ] ;
 
#line 11 "task3.pqc"
 char user [ 150 ] ;
 
#line 12 "task3.pqc"
 char password [ 150 ] ;
 
#line 13 "task3.pqc"
 char host [ 50 ] ;
 
#line 14 "task3.pqc"
 char port [ 50 ] ;
 
#line 15 "task3.pqc"
 int course_id ;
 
#line 16 "task3.pqc"
 bool isId = false ;
 
#line 17 "task3.pqc"
 int numberOfStudent ;
 
#line 18 "task3.pqc"
 int id ;
 
#line 19 "task3.pqc"
 char fname [ 64 ] ;
 
#line 20 "task3.pqc"
 char lname [ 64 ] ;
 
#line 21 "task3.pqc"
 char opis [ 64 ] ;
/* exec sql end declare section */
#line 22 "task3.pqc"


int main(int argc, char** argv){

        strcpy(user, dbuser);
        strcpy(password, dbpass);
        strcpy(host, dbhost);
        strcpy(port, dbport);

        if(argc >= 2){
                course_id = atoi(argv[1]);
                isId = true;
        }

        if(isId){
                printf("Podano id: %d\n", course_id);


                { ECPGconnect(__LINE__, 0, dbname , user , password , "conn", 0); }
#line 40 "task3.pqc"


                { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select count ( * ) from ( select id_uczestnik , imie , nazwisko , opis from lab04 . uczest_kurs join lab04 . uczestnik on id_uczestnik = id_uczest join lab04 . kurs_opis using ( id_kurs ) where id_kurs = $1  order by 1 ) as counter", 
	ECPGt_int,&(course_id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, 
	ECPGt_int,&(numberOfStudent),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 48 "task3.pqc"


                printf("Liczba studentow: %d\n\n", numberOfStudent);

                /* declare ucz cursor for select id_uczestnik , imie , nazwisko , opis from lab04 . uczest_kurs join lab04 . uczestnik on id_uczestnik = id_uczest join lab04 . kurs_opis using ( id_kurs ) where id_kurs = $1  order by 1 */
#line 58 "task3.pqc"

                { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "declare ucz cursor for select id_uczestnik , imie , nazwisko , opis from lab04 . uczest_kurs join lab04 . uczestnik on id_uczestnik = id_uczest join lab04 . kurs_opis using ( id_kurs ) where id_kurs = $1  order by 1", 
	ECPGt_int,&(course_id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, ECPGt_EORT);}
#line 59 "task3.pqc"


                for(int i = 0; i < numberOfStudent; i++){
                        { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch next from ucz", ECPGt_EOIT, 
	ECPGt_int,&(id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(fname),(long)64,(long)1,(64)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(lname),(long)64,(long)1,(64)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,(opis),(long)64,(long)1,(64)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 62 "task3.pqc"

                        printf("%d | %s \t| %s \t| %s\n", id, fname, lname, opis);
                }
                { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "close ucz", ECPGt_EOIT, ECPGt_EORT);}
#line 65 "task3.pqc"


                { ECPGdisconnect(__LINE__, "ALL");}
#line 67 "task3.pqc"

        }
        else
                printf("Nie podano id\n");

        
        return 0;
}