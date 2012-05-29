module Sequel
  module Collation
    module SQLite
      private

      def schema_parse_table(table_name, opts)
        m = output_identifier_meth(opts[:dataset])
        schema = parse_pragma(table_name, opts).map do |row|
          [m.call(row.delete(:name)), row]
        end
        add_collation(table_name, schema)
        schema
      end

      def add_collation(table_name, schema)
        # Parse the CREATE TABLE line. This is not ideal, but the only
        # alternative is to create compiled extensions. The jdbc-sqlite3
        # gem does not expose the sqlite3_table_column_metadata function.
        metadata_dataset.with_sql("SELECT sql FROM sqlite_master WHERE tbl_name = ?", input_identifier_meth(opts[:dataset]).call(table_name)).map do |row|
          sql = row[:sql]
          cols = sql[/\((.+)\)/]
          cols.scan(/(['"\[`])(.+?)\1\s+\w+(?:\(\d+(?:,\d+)?\))?/) do |id|
            p id
          end
        end
      end
    end

    ADAPTER_MAP[:sqlite] = SQLite
  end
end
