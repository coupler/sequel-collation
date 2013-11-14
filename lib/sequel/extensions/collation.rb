module Sequel
  module Collation
    ADAPTER_MAP = {}

    @@suppress_warnings = false
    def self.suppress_warnings=(value)
      @@suppress_warnings = value
    end

    def self.extended(base)
      db_type = base.database_type
      unless ADAPTER_MAP.has_key?(db_type)
        # attempt to load the adapter file
        begin
          require("sequel/extensions/collation/adapters/#{db_type}")
        rescue LoadError => e
          if !@@suppress_warnings
            warn "NOTE: Sequel::Collation does not support the database type '#{db_type}'"
          end
          return
        end
      end
      base.extend(ADAPTER_MAP[db_type])
    end
  end
end
