module Sequel
  module Collation
    ADAPTER_MAP = {}

    def self.extended(base)
      db_type = base.database_type
      unless ADAPTER_MAP.has_key?(db_type)
        # attempt to load the adapter file
        begin
          Sequel.tsk_require("sequel/extensions/collation/adapters/#{db_type}")
        rescue LoadError => e
          raise Sequel.convert_exception_class(e, AdapterNotFound)
        end
      end
      base.extend(ADAPTER_MAP[db_type])
    end
  end
end
