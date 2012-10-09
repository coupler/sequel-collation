require 'helper'

class TestH2 < Test::Unit::TestCase
  test "extending module" do
    database_for("h2") do |db|
      db.extend(Sequel::Collation)
    end
  end

  test "schema shows collation" do
    database_for("h2") do |db|
      db.extend(Sequel::Collation)
      db.run("SET COLLATION ENGLISH")
      db.create_table!(:foo) do
        String :bar
      end
      schema = db.schema(:foo)
      assert_equal "ENGLISH", schema.assoc(:bar)[1][:collation]
    end
  end
end
