module Sequel
  module Collation
    module H2
      private
      def schema_parse_table(table_name, opts)
        result = super(table_name, opts)
        ds = metadata_dataset.
          select(:COLLATION_NAME).
          from(:INFORMATION_SCHEMA__COLUMNS).
          filter(:LOWER.sql_function(:TABLE_NAME) => :LOWER.sql_function(table_name))

        result.each do |(name, info)|
          row = ds.filter(:LOWER.sql_function(:COLUMN_NAME) => :LOWER.sql_function(name.to_s)).first
          if row[:collation_name] == "OFF"
            info[:collation] = nil
          else
            info[:collation] = row[:collation_name]
          end
        end
        result
      end
    end
    ADAPTER_MAP[:h2] = H2
  end
end
