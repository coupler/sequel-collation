#include <sqlite3ext.h>
SQLITE_EXTENSION_INIT1

static void
get_collation(context, argc, argv)
  sqlite3_context *context;
  int argc;
  sqlite3_value **argv;
{
  sqlite3 *db;
  const unsigned char *table_name, *column_name;
  char const *zDataType, *zCollSeq;
  int notNull, primaryKey, autoinc;

  db = sqlite3_context_db_handle(context);
  table_name = sqlite3_value_text(argv[0]);
  column_name = sqlite3_value_text(argv[1]);

  sqlite3_table_column_metadata(db, 0, (const char *) table_name,
      (const char *) column_name, &zDataType, &zCollSeq, &notNull,
      &primaryKey, &autoinc);
  sqlite3_result_text(context, zCollSeq, -1, SQLITE_STATIC);
}

int
sqlite3_extension_init(db, pzErrMsg, pApi)
  sqlite3 *db;          /* The database connection */
  char **pzErrMsg;      /* Write error messages here */
  const sqlite3_api_routines *pApi;  /* API methods */
{
  SQLITE_EXTENSION_INIT2(pApi)
  sqlite3_create_function(db, "get_collation", 2, SQLITE_ANY, 0, get_collation, 0, 0);
  return 0;
}
