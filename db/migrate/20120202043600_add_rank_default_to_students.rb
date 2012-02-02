class AddRankDefaultToStudents < ActiveRecord::Migration
  def change
    change_column_default :students, :rank, 10
  end
end