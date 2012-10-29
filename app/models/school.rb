class School < ActiveRecord::Base
  has_many :students, :order => "last_name ASC"
end
