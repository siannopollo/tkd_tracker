class Attendance < ActiveRecord::Base
  belongs_to :student
  
  after_initialize :assign_default_date
  
  protected
    def assign_default_date
      self.date ||= Date.today
    end
end
