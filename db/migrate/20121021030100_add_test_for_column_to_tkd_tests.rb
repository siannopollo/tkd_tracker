class AddTestForColumnToTkdTests < ActiveRecord::Migration
  def up
    add_column :tkd_tests, :test_for, :string
  end

  def down
     remove_column :tkd_tests, :test_for
  end
end
