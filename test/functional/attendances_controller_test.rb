require File.dirname(__FILE__) + '/../test_helper'

class AttendancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opendoor_students)
    assert_not_nil assigns(:fairview_students)
  end

  test "should create attendance" do
    assert_difference('Attendance.count') do
      post :create, :"student#{students(:one).id}" => {1 => 1}
    end
  end

  test "should update attendance" do
    put :update, :id => attendances(:one).id, :attendance => { }
    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should destroy attendance" do
    assert_difference('Attendance.count', -1) do
      delete :destroy, :id => attendances(:one).id
    end

    assert_redirected_to attendances_path
  end
end
