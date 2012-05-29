require 'rubygems'
require 'treetop'
require 'debugger'
require './sqlite_schema'

parser = SQLiteSchemaParser.new
result = parser.parse('CREATE TABLE foo (id INTEGER, bar REAL(10,5), foo TEXT COLLATE HUGE)')
if !result
  puts parser.failure_reason
  puts parser.failure_line
  puts parser.failure_column
else
  p result.column_defs.columns.collect { |c| c.collation }
end
