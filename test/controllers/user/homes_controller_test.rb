require 'test_helper'

class User::HomesControllerTest < ActionController::TestCase
  setup do
    @user_home = user_homes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_homes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_home" do
    assert_difference('User::Home.count') do
      post :create, user_home: {  }
    end

    assert_redirected_to user_home_path(assigns(:user_home))
  end

  test "should show user_home" do
    get :show, id: @user_home
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_home
    assert_response :success
  end

  test "should update user_home" do
    patch :update, id: @user_home, user_home: {  }
    assert_redirected_to user_home_path(assigns(:user_home))
  end

  test "should destroy user_home" do
    assert_difference('User::Home.count', -1) do
      delete :destroy, id: @user_home
    end

    assert_redirected_to user_homes_path
  end
end
