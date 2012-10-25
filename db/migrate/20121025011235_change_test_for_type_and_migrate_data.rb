class ChangeTestForTypeAndMigrateData < ActiveRecord::Migration
  def up
    change_column :tkd_tests, :test_for, :integer

    Student.all.each do |student|
      test = TkdTest.find_all_by_student_id(student.id).first
      test.test_for = student.rank
      test.save
    end
  end

  def down
    change_column :tkd_tests, :test_for, :string
    TkdTest.all.each do |test|
      test.test_for = nil
      test.save
    end
  end
end
