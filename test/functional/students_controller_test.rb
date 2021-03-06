require File.dirname(__FILE__) + '/../test_helper'

class StudentsControllerTest < ActionController::TestCase
  fixtures :schools, :students
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, :student => {
        :first_name => 'Jim', :last_name => 'Jones',
        :rank => 10, :school_id => schools(:one).id
      }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, :id => students(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => students(:one).id
    assert_response :success
  end

  test "should update student" do
    put :update, :id => students(:one).id, :student => { }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, :id => students(:one).id
    end

    assert_redirected_to students_path
  end
end
