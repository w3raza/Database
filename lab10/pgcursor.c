#include <stdlib.h>
#include <string.h>
#include <libpq-fe.h>
#include "lab10pq.h"

void printTuples(PGresult *result)
{
  switch(PQresultStatus(result)) {
    case PGRES_TUPLES_OK:{
      int n = 0, r = 0;
      int nrows   = PQntuples(result);
      int nfields = PQnfields(result);
      printf("liczba zwroconych rekordow = %d\n", nrows);
      printf("liczba zwroconych kolumn   = %d\n", nfields);
      for(r = 0; r < nrows; r++) {
        for(n = 0; n < nfields; n++)
           printf(" %s = %s", PQfname(result, n),PQgetvalue(result,r,n));
        printf("\n");
      }
    }
  }
}

void doSQL(PGconn *conn, char *command)
{
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

int main()
{
  PGresult *result;
  PGconn *conn;
  int nTuples = 0;
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

  doSQL(conn, "BEGIN work");
     doSQL(conn, "DECLARE mcursor CURSOR FOR SELECT * FROM lab04.person");
     do {
       result = PQexec(conn, "FETCH 1 IN mcursor");
       if ( PQresultStatus(result) == PGRES_TUPLES_OK) {
          nTuples = PQntuples(result);
          printTuples(result);
          PQclear(result);
       } else nTuples = 0;
     } while (nTuples) ;
     doSQL(conn, "CLOSE mcursor");
     doSQL(conn, "COMMIT work");
  PQfinish(conn);
  return EXIT_SUCCESS;
}