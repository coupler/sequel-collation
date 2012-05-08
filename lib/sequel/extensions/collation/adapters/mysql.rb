module Sequel
  module Collation
    module MySQL
      private
      def schema_parse_table(table_name, opts)
        m = output_identifier_meth(opts[:dataset])
        im = input_identifier_meth(opts[:dataset])
        table = SQL::Identifier.new(im.call(table_name))
        table = SQL::QualifiedIdentifier.new(im.call(opts[:schema]), table) if opts[:schema]
        metadata_dataset.with_sql("SHOW FULL COLUMNS FROM ?", table).map do |row|
          row[:auto_increment] = true if row.delete(:Extra).to_s =~ /auto_increment/io
          row[:allow_null] = row.delete(:Null) == 'YES'
          row[:default] = row.delete(:Default)
          row[:primary_key] = row.delete(:Key) == 'PRI'
          row[:default] = nil if blank_object?(row[:default])
          row[:db_type] = row.delete(:Type)
          row[:type] = schema_column_type(row[:db_type])
          row[:collate] = row.delete(:Collation)
          [m.call(row.delete(:Field)), row]
        end
      end
    end
    ADAPTER_MAP[:mysql] = MySQL
  end
end
