require File.dirname(__FILE__) + '/../test_helper'
require 'date'

class StudentTest < ActiveSupport::TestCase
  
  test "white belt ineligible to test because of testing date" do
    student = student_with_test_and_attendance
    student.attendances.first.number_of_classes = 28

    assert(!student.is_eligible_to_test(student.tests.first.date + 1))
  end

  test "white belt ineligible to test due to not enough classes" do
    student = student_with_test_and_attendance

    attendance =  student.attendances.first
    attendance.number_of_classes = 5

    test_date = student.tests.first.date >> 5

    assert(!student.is_eligible_to_test(test_date))
    
    attendance.number_of_classes = 23
    assert(!student.is_eligible_to_test(test_date))
  end

  test "white belt eligible to test" do
    student = student_with_test_and_attendance
    student.attendances.first.number_of_classes = 24

    assert(student.is_eligible_to_test(student.tests.first.date >> 3))
  end

  test "mighty kid transition to regular class" do
    student = student_with_test_and_attendance
    student.rank = 11

    attendance = student.attendances.first
    attendance.number_of_classes = 12

    test_date = student.tests.first.date

    assert(student.is_eligible_to_test(test_date >> 3))
    
    assert(!student.is_eligible_to_test(test_date >> 2))
    
    attendance.number_of_classes = 11
    assert(!student.is_eligible_to_test(test_date >> 3))
  end

  test "first dan" do
    student = student_with_test_and_attendance
    student.rank = 0

    test =  student.tests.first

    attendance = student.attendances.first
    attendance.number_of_classes = 1000

    expected_test_date = test.date >> 10
    assert(!student.is_eligible_to_test(expected_test_date))
    
    test.date = Date.civil(2008, 1, 16)
    assert(student.is_eligible_to_test(expected_test_date))
    
    attendance.number_of_classes = 0
    assert(student.is_eligible_to_test(expected_test_date))
  end

  test "classes since last test works when attendance and test dates the same" do
    student = student_with_test_and_attendance
    attendance = student.attendances.first
    attendance.date = student.tests.first.date
    attendance.number_of_classes = 10

    assert_equal(attendance.number_of_classes, student.number_of_classes_since_last_test)
  end

  def student_with_test_and_attendance
    student = Student.new(:rank => 10)
    student.attendances = Array.new
    student.tests = Array.new

    student.tests << TkdTest.new(:date => Date.civil(2010, 1, 6))
    student.attendances << Attendance.new(:date => student.tests.first.date + 1)

    student
  end
end
