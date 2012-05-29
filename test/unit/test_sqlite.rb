require 'helper'

class TestSqlite3 < Test::Unit::TestCase
  test "extending module" do
    database_for("sqlite") do |db|
      db.extend(Sequel::Collation)
    end
  end

  test "schema shows collation" do
    database_for("sqlite") do |db|
      db.extend(Sequel::Collation)
      db.create_table!(:foo) do
        String :bar, :collate => "RTRIM"
      end
      schema = db.schema(:foo)
      assert_equal "RTRIM", schema.assoc(:bar)[1][:collate]
    end
  end
end
