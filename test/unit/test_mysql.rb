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
        String :bar, :collation => "latin1_swedish_ci"
      end
      schema = db.schema(:foo)
      assert_equal "latin1_swedish_ci", schema.assoc(:bar)[1][:collation]
    end
  end

  test "schema removes Comment and Privileges" do
    database_for("mysql") do |db|
      db.extend(Sequel::Collation)
      db.create_table!(:foo) do
        String :bar, :collation => "latin1_swedish_ci"
      end
      schema = db.schema(:foo)
      assert !schema.assoc(:bar)[1].has_key?(:Comment)
      assert !schema.assoc(:bar)[1].has_key?(:Privileges)
    end
  end
end
