require 'mkmf'

if have_library('sqlite3', 'sqlite3_libversion_number') &&
   have_header('sqlite3.h') &&
   have_func('sqlite3_load_extension', 'sqlite3.h') &&
   have_func('sqlite3_table_column_metadata', 'sqlite3.h')

  create_makefile('sqlite3-extension')
end
