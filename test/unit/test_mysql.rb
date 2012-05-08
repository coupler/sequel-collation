require 'helper'

class TestMysql < Test::Unit::TestCase
  test "extending module" do
    database_for("mysql") do |db|
      db.extend(Sequel::Collation)
    end
  end

  test "schema shows collation" do
    database_for("mysql") do |db|
      db.extend(Sequel::Collation)
      db.create_table!(:foo) do
        String :bar, :collate => "latin1_swedish_ci"
      end
      schema = db.schema(:foo)
      assert_equal "latin1_swedish_ci", schema.assoc(:bar)[1][:collate]
    end
  end
end
