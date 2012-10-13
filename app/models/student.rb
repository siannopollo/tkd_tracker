require 'date'
require 'testing_requirements'

class Student < ActiveRecord::Base
  has_many :attendances, :order => 'date DESC'
  has_many :tests, :class_name => 'TkdTest', :order => 'date DESC'
  belongs_to :school
  
  after_initialize :assign_default_last_test_date
  
  validates_presence_of :first_name, :last_name, :school_id, :rank
  
  scope :active, where(:active => true)
  
  def classes_needed_to_test()
    delta_classes = number_of_classes_since_last_test()
    remaining_classes = TestingRequirements.by_gup[rank - 1]["classes"] - delta_classes
    if remaining_classes < 0 then 
      return 0 
    end
    return remaining_classes
  end
  
  def earliest_eligible_test_date()
    last_test >> TestingRequirements.by_gup[rank - 1]["months"]
  end
  
  def is_eligible_to_test(actual_test_date, credit_for_additional_classes=0)
    
    test_requirement = TestingRequirements.by_gup[rank - 1]
    
    eligible_test_date = last_test >> test_requirement["months"]
    if actual_test_date < eligible_test_date then
      return false
    end
     
    classes_taken = number_of_classes_since_last_test() + credit_for_additional_classes.to_i   
    if classes_taken < test_requirement["classes"] then
      return false
    end
    
    return true
  end

  def total_classes_needed_for_next_test()
    TestingRequirements.by_gup[rank - 1]["classes"]
  end

  def number_of_classes_since_last_test()
    class_count = 0;
    attendances.each do |attendance|
      if attendance.date > last_test then
        class_count += attendance.number_of_classes
      end
    end
    return class_count
  end


  def is_valid?(errors)
    if !has_value?(first_name) || !has_value?(last_name) then
        errors << "A first and last name are required."
    end
    
    if !has_value?(last_test) || !date_valid?(last_test) then
      errors << "Last test must be a valid date."
    end
    
    if !has_value?(school_id)
      errors << "Please select a school."
    end
    
    if !has_value?(rank)
      errors << "Please select a rank."
    end
    
    errors.empty?  
    
  end

 protected
  def assign_default_last_test_date
    self.last_test ||= Date.today
  end

 def has_value?(param)
   param && !param.blank?
 end
 
 def date_valid?(date)
   begin
     Date.parse(date.to_s)
   rescue ArgumentError
     return false
   end  
   return true
 end
 
end
