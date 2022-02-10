#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include <stdlib.h>

#define SQL_QUERY_SIZE      1000 
#define PARAM_ARRAY_SIZE    2

int odbc_insert()
{
    SQLHENV 	hEnv = NULL;
	SQLHDBC     hDbc = NULL;
	SQLHSTMT    hStmt = NULL;
	CHAR*      pwszConnStr;
	CHAR       wszInput[SQL_QUERY_SIZE];
	SQLRETURN	ret;
	//char		tmpbuf[256];
	int row = 0;
	SQLINTEGER  uczestnikID[] = { 1,2 };
	SQLUSMALLINT ParamStatusArray[PARAM_ARRAY_SIZE];
	SQLLEN       ParamsProcessed = 0;

    SQLCHAR      imie[32];
    SQLCHAR      nazwisko[32];
    SQLLEN       length_imie=0;
    SQLLEN       length_nazwisko=0;

	// Allocate an environment
	if (SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv) == SQL_ERROR)
	{
		fprintf(stderr, "Unable to allocate an environment handle\n");
		exit(-1);
	}

	// Register this as an application that expects 3.x behavior,
	// Allocate a connection
	RETCODE rc = SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0);
	if (rc != SQL_SUCCESS)
	{
		// HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		exit(-1);
	}

	rc = SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);
	if (rc != SQL_SUCCESS)
	{
		// HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		goto Exit;
	}

	pwszConnStr = "DB1LAB01";

	rc = SQLConnect(hDbc, pwszConnStr, SQL_NTS, NULL, 0, NULL, 0);

	fprintf(stderr, "Connected!\n");

	rc = SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);

    strcpy(wszInput, "INSERT INTO lab04.uczestnik VALUES(?,?);");

    RETCODE     RetCode;
    SQLSMALLINT sNumResults;

	// Execute the query
	// Prepare Statement
	//RetCode = SQLPrepare(hStmt, wszInput, SQL_NTS);

	RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, (SQLPOINTER)PARAM_ARRAY_SIZE, 0);
	RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAM_STATUS_PTR, ParamStatusArray, PARAM_ARRAY_SIZE);
	RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, &ParamsProcessed, 0);

    strcpy(imie, "Andrzej"); 
    length_imie=strlen(imie);

    strcpy(nazwisko, "Kaczka"); 
    length_nazwisko=strlen(nazwisko);

    // Bind array values of parameter 1
    RetCode = SQLBindParameter(hStmt, 1, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, length_imie, 0, imie, 32, &length_imie);
    RetCode = SQLBindParameter(hStmt, 2, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, length_nazwisko, 0, nazwisko, 32, &length_nazwisko);
	
    RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);
	//RetCode = SQLExecute(hStmt);
	//RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);

	// Retrieve number of columns
	rc = SQLNumResultCols(hStmt, &sNumResults);
	//wprintf(L"Number of Result Columns %i\n", sNumResults);


	switch (RetCode)
	{
	case SQL_SUCCESS_WITH_INFO:
	{
		// HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
	}
	case SQL_SUCCESS:
	{
		rc = SQLNumResultCols(hStmt, &sNumResults);

		if (sNumResults > 0)
		{
			//DisplayResults(hStmt, sNumResults);
			while (SQL_SUCCEEDED(ret = SQLFetch(hStmt))) {
				SQLUSMALLINT i;
				printf("Row %d\n", row++);
				// Loop through the columns */
				for (i = 1; i <= sNumResults; i++) {
					SQLLEN indicator;
					SQLCHAR buf[512];
					// retrieve column data as a string
					ret = SQLGetData(hStmt, i, SQL_C_CHAR,	buf, sizeof(buf), &indicator);
					if (SQL_SUCCEEDED(ret)) {
						/* Handle null columns */
						if (indicator == SQL_NULL_DATA) strcpy(buf, "NULL");
						printf("  Column %u : %s\n", i, buf);
					}
				}
			}
		}
		else
		{
			SQLLEN cRowCount;

			rc = SQLRowCount(hStmt, &cRowCount);
			if (cRowCount >= 0)
			{
				printf("%Id %s affected\n", cRowCount, cRowCount == 1 ? L"row" : L"rows");
			}
		}
		break;
	}

	case SQL_ERROR:
	{
		// HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
		break;
	}

	default:
		fprintf(stderr, "Unexpected return code %hd!\n", RetCode);

	}
	rc = SQLFreeStmt(hStmt, SQL_CLOSE);

Exit:

	if (hStmt)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
	}

	if (hDbc)
	{
		SQLDisconnect(hDbc);
		SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
	}

	if (hEnv)
	{
		SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
	}

	printf("\nUFF - pozamiatane\n");

	return 0;
}

int main() {
        odbc_insert();
        return 0;
}