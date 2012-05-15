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
      end

      def add_collation(table_name, schema)
        synchronize(opts[:server]) do |conn|
          conn.enable_load_extension(true)
          conn.load_extension(File.join(File.dirname(__FILE__), "sqlite3-extension.so"))

          schema.each do |column|
            conn.execute("SELECT get_collation(?, ?)", [table_name, column[0].to_s]) do |row|
              column[1][:collate] = row[0]
            end
          end
        end
      end
    end

    ADAPTER_MAP[:sqlite] = SQLite
  end
end
