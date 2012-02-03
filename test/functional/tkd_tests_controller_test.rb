require File.dirname(__FILE__) + '/../test_helper'

class TkdTestsControllerTest < ActionController::TestCase
  fixtures :tkd_tests
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test" do
    assert_difference('TkdTest.count') do
      post :create, :test => { }
    end

    assert_redirected_to tkd_test_path(assigns(:test))
  end

  test "should show test" do
    get :show, :id => tkd_tests(:test_one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tkd_tests(:test_one).to_param
    assert_response :success
  end

  test "should update test" do
    put :update, :id => tkd_tests(:test_one).to_param, :test => { }
    assert_redirected_to tkd_test_path(assigns(:test))
  end

  test "should destroy test" do
    assert_difference('TkdTest.count', -1) do
      delete :destroy, :id => tkd_tests(:test_one).to_param
    end

    assert_redirected_to tkd_tests_path
  end
end
