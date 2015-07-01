require 'test_helper'

class User::ReportsControllerTest < ActionController::TestCase
  setup do
    @user_report = user_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_report" do
    assert_difference('User::Report.count') do
      post :create, user_report: {  }
    end

    assert_redirected_to user_report_path(assigns(:user_report))
  end

  test "should show user_report" do
    get :show, id: @user_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_report
    assert_response :success
  end

  test "should update user_report" do
    patch :update, id: @user_report, user_report: {  }
    assert_redirected_to user_report_path(assigns(:user_report))
  end

  test "should destroy user_report" do
    assert_difference('User::Report.count', -1) do
      delete :destroy, id: @user_report
    end

    assert_redirected_to user_reports_path
  end
end
