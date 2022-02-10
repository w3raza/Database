#include <stdlib.h>
#include <string.h>
#include <libpq-fe.h>
#include "lab10pq.h"

// 2) Korzystając z przykładu zawartego w pliku doquery.c napisać program, który tworzy tabelę person o strukturze
// id INTEGER PRIMARY KEY, fname VARCHAR, lname VARCHAR. Rozmiar fname i lname to 60.
// Insertuje rekordy o id 10,29,31,66. Zmienia fname i lname w rekordzie dla id 29. Usuwa rekord dla id 66.
// Do usuwania rekordu napisać funkcję, której argumentem ma być id usuwanego rekordu.
// Na zakończenie program wypisuje na konsoli zawartość tabeli.

void doSQL(PGconn *conn, char *command)
{
  PGresult *result;
  printf("------------------------------\n");
  printf("%s\n", command);
  result = PQexec(conn, command);
  printf("stan polecenia:              %s\n", PQresStatus(PQresultStatus(result)));
  printf("opis stanu:                  %s\n", PQresultErrorMessage(result));
  printf("liczba zmienionych rekordow: %s\n", PQcmdTuples(result));

  switch(PQresultStatus(result))
  {
    case PGRES_TUPLES_OK:
    {
      int n = 0, r = 0;
      int nrows   = PQntuples(result);
      int nfields = PQnfields(result);
      printf("liczba zwroconych rekordow = %d\n", nrows);
      printf("liczba zwroconych kolumn   = %d\n", nfields);
      for(r = 0; r < nrows; r++)
      {
        for(n = 0; n < nfields; n++)
        {
           printf(" %s = %s", PQfname(result, n),PQgetvalue(result,r,n));
        }
        printf("\n");
      }
    }
  }
  PQclear(result);
}

void executeOrder(PGconn *conn, int id)
{
    const int N1 = snprintf(NULL, 0, "%d", id);
    const int N2 = snprintf(NULL, 0, "DELETE FROM lab04.person WHERE id_person = ;");
    char command[N1+N2+1];
    sprintf(command, "DELETE FROM lab04.person WHERE id_person = %d;", id);
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
        doSQL(conn, "DROP TABLE lab04.person CASCADE;");
        doSQL(conn, "CREATE TABLE lab04.person (id_person INTEGER PRIMARY KEY, fname VARCHAR(60), lname VARCHAR(60));");
        doSQL(conn, "INSERT INTO lab04.person values(10, 'Tomasz', 'Ategoniemasz'),\
                                                     (29, 'Janusz', 'Fabryka'),\
                                                     (31, 'Gerwazy', 'Paleta'),\
                                                     (66, 'Jan', 'Anakin');");
        doSQL(conn, "UPDATE lab04.person SET fname = 'Janina', lname = 'Manufaktura' WHERE id_person = 29;");
        executeOrder(conn, 66);
        doSQL(conn, "SELECT * FROM lab04.person;");
    }
    PQfinish(conn);
    return EXIT_SUCCESS;
}