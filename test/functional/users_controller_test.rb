require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @user
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get destroy" do
    get :destroy, id: @user
    assert_redirected_to users_path
  end

end
