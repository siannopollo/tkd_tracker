
class TkdTest < ActiveRecord::Base
  belongs_to :student
#  validates_presence_of :date

  after_initialize :assign_default_values

  def assign_default_values
    self.date ||= Date.today
  end

end
