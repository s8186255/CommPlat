require 'test_helper'

class Function::HomesControllerTest < ActionController::TestCase
  setup do
    @function_home = function_homes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:function_homes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create function_home" do
    assert_difference('Function::Home.count') do
      post :create, function_home: {  }
    end

    assert_redirected_to function_home_path(assigns(:function_home))
  end

  test "should show function_home" do
    get :show, id: @function_home
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @function_home
    assert_response :success
  end

  test "should update function_home" do
    patch :update, id: @function_home, function_home: {  }
    assert_redirected_to function_home_path(assigns(:function_home))
  end

  test "should destroy function_home" do
    assert_difference('Function::Home.count', -1) do
      delete :destroy, id: @function_home
    end

    assert_redirected_to function_homes_path
  end
end
