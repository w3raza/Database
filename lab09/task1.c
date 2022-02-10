/* Processed by ecpg (13.4 (Debian 13.4-1.pgdg90+1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "task1.pqc"
#include <stdlib.h>

char * dbuser = "u9zaczyk";
char * dbpass  = "9zaczyk";
char * dbhost = "pascal";
char * dbport = "5432"; 

/* exec sql begin declare section */
     
     
     
     
     
     
     
     
     
     
     

#line 9 "task1.pqc"
 char db [ 150 ] ;
 
#line 10 "task1.pqc"
 char user [ 150 ] ;
 
#line 11 "task1.pqc"
 char password [ 150 ] ;
 
#line 12 "task1.pqc"
 char host [ 50 ] ;
 
#line 13 "task1.pqc"
 char port [ 50 ] ;
 
#line 14 "task1.pqc"
 char catalog [ 50 ] ;
 
#line 15 "task1.pqc"
 char database [ 50 ] ;
 
#line 16 "task1.pqc"
 char query [ 50 ] ;
 
#line 17 "task1.pqc"
 char schema [ 50 ] ;
 
#line 18 "task1.pqc"
 char schemas [ 100 ] ;
 
#line 19 "task1.pqc"
 char uname [ 50 ] ;
/* exec sql end declare section */
#line 20 "task1.pqc"


int main(){
    strcpy(user, dbuser);
    strcpy(password, dbpass);
    strcpy(host, dbhost);
    strcpy(port, dbport);

    { ECPGconnect(__LINE__, 0, db , user , password , "conn", 0); }
#line 28 "task1.pqc"


    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_catalog", ECPGt_EOIT, 
	ECPGt_char,(catalog),(long)50,(long)1,(50)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 30 "task1.pqc"

    printf("Catalog       = %s \n", catalog);

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_database ( )", ECPGt_EOIT, 
	ECPGt_char,(database),(long)50,(long)1,(50)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 33 "task1.pqc"

    printf("Database      = %s \n", database);

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_user", ECPGt_EOIT, 
	ECPGt_char,(uname),(long)50,(long)1,(50)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 36 "task1.pqc"

    printf("User          = %s \n", uname);

    printf("Port          = %s \n", port);

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select inet_client_port ( )", ECPGt_EOIT, 
	ECPGt_char,(port),(long)50,(long)1,(50)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 41 "task1.pqc"

    printf("Host          = %s \n", host);

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_query ( )", ECPGt_EOIT, 
	ECPGt_char,(query),(long)50,(long)1,(50)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 44 "task1.pqc"

    printf("Query         = %s \n", query);

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select current_schema ( )", ECPGt_EOIT, 
	ECPGt_char,(schema),(long)50,(long)1,(50)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 47 "task1.pqc"

    printf("Schema[()]    = %s \n", schema);

    { ECPGdisconnect(__LINE__, "ALL");}
#line 50 "task1.pqc"

    return 0;
}