/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "task2.pqc"
#include <stdio.h>
#include <stdlib.h>

char * dbuser = "u9zaczyk";
char * dbpass  = "9zaczyk";
char * dbhost = "pascal";
char * dbport = "5432"; 

/* exec sql begin declare section */
         
         
         
         
         
           
           

#line 10 "task2.pqc"
 char user [ 150 ] ;
 
#line 11 "task2.pqc"
 char password [ 150 ] ;
 
#line 12 "task2.pqc"
 char host [ 50 ] ;
 
#line 13 "task2.pqc"
 char port [ 50 ] ;
 
#line 14 "task2.pqc"
 char email [ 64 ] ;
 
#line 15 "task2.pqc"
 int id = 0 ;
 
#line 16 "task2.pqc"
 bool is_email = false ;
/* exec sql end declare section */
#line 17 "task2.pqc"


int main(int argc, char** argv){
        strcpy(user, dbuser);
        strcpy(password, dbpass);
        strcpy(host, dbhost);
        strcpy(port, dbport);

        if(argc >= 2){
                id = atoi(argv[1]);
        }

        if(argc >= 3){
                strcpy(email,argv[2]);
                is_email = true;
        }


        { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set search_path to lab04", ECPGt_EOIT, ECPGt_EORT);}
#line 35 "task2.pqc"


        if(id != 0 && is_email){
                { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "update uczestnik set email = $1  where id_uczestnik = $2 ", 
	ECPGt_char,(email),(long)64,(long)1,(64)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_int,&(id),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EOIT, ECPGt_EORT);}
#line 40 "task2.pqc"

                printf("UPDATE\n");
                printf("Id: %d\n", id);
                printf("E-mail: %s\n", email);
                        
        }
        else if(id == 0) 
                printf("Nie podano ID\n");    
        else
                printf("Nie podano email\n");

        { ECPGdisconnect(__LINE__, "ALL");}
#line 51 "task2.pqc"

        return 0;
}