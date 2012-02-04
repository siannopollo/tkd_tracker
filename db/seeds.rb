# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

school = School.create :name => "Bob's TKD"

student = school.students.create({
  :first_name => 'Bobby', :last_name => 'Jones',
  :email_address => 'bobby@example.com'
})

student.attendances.create :date => Date.yesterday, :number_of_classes => 2