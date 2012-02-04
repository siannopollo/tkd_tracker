class SwitchInacitveToActiveOnStudents < ActiveRecord::Migration
  def up
    rename_column :students, :inactive, :active
    Student.reset_column_information
    Student.find_each {|s| s.update_column :active, !s.active}
    change_column_default :students, :active, true
  end
  
  def down
    rename_column :students, :active, :inactive
    Student.reset_column_information
    Student.find_each {|s| s.update_column :inactive, !s.inactive}
    change_column_default :students, :active, false
  end
end