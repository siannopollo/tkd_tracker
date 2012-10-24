require 'student'
require 'tkd_test'

class RemoveLastTestFromFromStudent < ActiveRecord::Migration
  def up
      Student.all.each do |student|
        student.tests.create :date => student.last_test
      end
      remove_column :students, :last_test
  end

  def down
    add_column :students, :last_test, :date

    Student.find_each do |student|
      student.last_test = tests.first.date
      student.save
    end
  end
end
