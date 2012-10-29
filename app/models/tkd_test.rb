
class TkdTest < ActiveRecord::Base
  belongs_to :student

  after_initialize :assign_default_values

  def assign_default_values
    self.date ||= Date.today
    self.test_for ||= 10
  end

end
