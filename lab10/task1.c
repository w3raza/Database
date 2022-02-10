// 1. Korzystając z przykładu napisać program zawierający funkcję 
// wypisującą na konsoli listę uczestników, których uczestnik_id 
// jest zawarty w pewnym przedziale. 
// Liczby wyznaczające przedział powinny być argumentami tej funkcji.

#include <stdlib.h>
#include <string.h>
#include <libpq-fe.h>
#include "lab10pq.h"

void printTuples(PGresult *result)
{
    int rows   = PQntuples(result);
    int columns = PQnfields(result);
    printf("liczba zwroconych rekordow = %d\n", rows);
    printf("liczba zwroconych kolumn   = %d\n", columns);
    for(int r = 0; r < rows; r++)
    {
        printf("|");
        for(int c = 0; c < columns; c++)
        {
            if(PQgetvalue(result,r,c)!=NULL)
                printf(" %s = %s", PQfname(result, c),PQgetvalue(result,r,c));
        }
        printf(" |\n");
    }
}

void doSQL(PGconn *conn, char *command){
  PGresult *result;
  printf("------------------------------\n");
  printf("%s\n", command);
  result = PQexec(conn, command);
  printf("stan polecenia:              %s\n", PQresStatus(PQresultStatus(result)));
  printf("opis stanu:                  %s\n", PQresultErrorMessage(result));
  printf("liczba zmienionych rekordow: %s\n", PQcmdTuples(result));
	
  if( PQresultStatus(result) == PGRES_TUPLES_OK )
  	printTuples(result);

  PQclear(result);
}

void print(PGconn *conn, int min, int max){
    const int N1 = snprintf(NULL, 0, "%d%d", min, max);
    const int N2 = snprintf(NULL, 0, "SELECT * FROM lab04.uczestnik WHERE id_uczestnik > AND id_uczestnik < ;");
    char command[N1+N2+1];

    sprintf(command, "SELECT * FROM lab04.uczestnik WHERE id_uczestnik >= %d AND id_uczestnik <= %d;", min, max);
    doSQL(conn, command);
}

int main()
{
    PGresult *result;
    PGconn *conn;
    char connection_str[256];

    strcpy(connection_str, "host=");
    strcat(connection_str, dbhost);
    strcat(connection_str, " port=");
    strcat(connection_str, dbport);
    strcat(connection_str, " dbname=");
    strcat(connection_str, dbname);
    strcat(connection_str, " user=");
    strcat(connection_str, dbuser);
    strcat(connection_str, " password=");
    strcat(connection_str, dbpassword);


    conn = PQconnectdb(connection_str);
    if (PQstatus(conn) == CONNECTION_BAD)
    {
        fprintf(stderr, "Connection to %s failed, %s", connection_str, PQerrorMessage(conn));
    }
    else
    {
        printf("Connected OK\n");
        print(conn, 1, 10);
    }
    PQfinish(conn);
    return EXIT_SUCCESS;

}