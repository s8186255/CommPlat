require 'test_helper'

class User::CeshisControllerTest < ActionController::TestCase
  setup do
    @user_ceshi = user_ceshis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_ceshis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_ceshi" do
    assert_difference('User::Ceshi.count') do
      post :create, user_ceshi: { name: @user_ceshi.name }
    end

    assert_redirected_to user_ceshi_path(assigns(:user_ceshi))
  end

  test "should show user_ceshi" do
    get :show, id: @user_ceshi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_ceshi
    assert_response :success
  end

  test "should update user_ceshi" do
    patch :update, id: @user_ceshi, user_ceshi: { name: @user_ceshi.name }
    assert_redirected_to user_ceshi_path(assigns(:user_ceshi))
  end

  test "should destroy user_ceshi" do
    assert_difference('User::Ceshi.count', -1) do
      delete :destroy, id: @user_ceshi
    end

    assert_redirected_to user_ceshis_path
  end
end
