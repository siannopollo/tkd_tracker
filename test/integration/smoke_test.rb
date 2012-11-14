require 'test_helper'
require 'factory_girl'

class SmokeTest < ActionDispatch::IntegrationTest

  test "Register Student" do
    get "/students/new"
    assert_response :success

    params = {:student_first_name => "JoeJoe",
              :student_last_name => "Young",
              :student_school_id => 1,
              :student_rank => 10}

    post("/students", params)
    assert_response(:unauthorized)

    env = {'HTTP_AUTHORIZATION' => get_basic_auth}
    post("/students", params, env)
    assert_response(:success)

  end

  test "Gather Attendance" do
     school = FactoryGirl.create(:school_with_students)

     get "/attendances?param1=#{school.id}"
     assert_response :success

     params = {
         "student#{school.students[0].id}" => {"class_one" => "1", "class_two" => "1", "class_three" => "0", "class_four" => "0"},
         "student#{school.students[1].id}" => {"class_one" => "0", "class_two" => "0", "class_three" => "0", "class_four" => "0"}
     }

     assert_equal(0, school.students[0].attendances.length)

     env = {"HTTP_AUTHORIZATION" => get_basic_auth}
     post "/attendances", params, env
    assert_response :success

    school.reload
    attendances = school.students[0].attendances
    assert_equal(1, attendances.length)
    assert_equal(2, attendances[0].number_of_classes)

  end

  def get_basic_auth
    user = 'teacher'
    pw = 'kickin4jesus'
    ActionController::HttpAuthentication::Basic.encode_credentials user, pw
  end

end
