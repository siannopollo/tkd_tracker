require 'student'

class ReportsController < ApplicationController

  def show
    report_method = params[:param1]
    case report_method
      when "test_eligibility"
        test_eligibility
        render("test_eligibility")
      when "certificate_request"
        certificate_request
        render("certificate_request")
      else
        puts "hello"
    end


  end

  def test_eligibility

      @schools = School.find(:all, :order => "name")
      @students_eligible_to_test = Array.new
      actual_test_date = params[:test_date]
      
      if actual_test_date != nil && actual_test_date.length > 0 then
        actual_test_date = Date.parse(actual_test_date)
        students = students_to_check(params[:school])
        
        fudge_factor = 0
        if params[:fudge_factor] != nil && params[:fudge_factor].length > 0 then
          fudge_factor = params[:fudge_factor]
        end
    
        students.each { |student| 
          if student.is_eligible_to_test(actual_test_date, fudge_factor) then
            @students_eligible_to_test << student
          end   
        }
        
        if @students_eligible_to_test.length == 0 then
          flash.now[:notice] = 'There are no students eligible to test on this date.'
        end
      end
 
    @students_eligible_to_test.sort! { |a,b| a.rank <=> b.rank}
    
  end

  def certificate_request
    test_date = params[:test_date]
    school_id = params[:school]
    @students_that_tested = Array.new
    @schools = School.all

    if test_date && school_id
      test_date = Date.parse(test_date)
      found = TkdTest.where("date = '#{test_date}' and result = 'passed' ")
      found.each do |test|
          student = Student.where("id = #{test.student_id} and school_id = '#{school_id}'" ).first
          if student
            @students_that_tested <<  student
          end
      end
    end

  end
  
  private
  def students_to_check(school_id)
    if school_id != nil && school_id.length > 0 then
      return Student.active.find(:all, :conditions => "school_id = '#{school_id}'")
    end
      
    Student.active.find(:all, :conditions => "inactive = 'f'")
  end
end
