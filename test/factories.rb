
FactoryGirl.define do

  factory :student do
    first_name "JoeJoe"
    last_name "Quiggly"
    rank 10
    school

  end

  factory :school do
    name "Ned's TKD"

    factory :school_with_students do

      ignore do
        student_count 2
      end

      after(:create) do |created_school, factory_values|
        FactoryGirl.create_list(:student, factory_values.student_count, school: created_school)
      end
    end
  end

end