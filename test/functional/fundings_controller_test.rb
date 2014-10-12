require 'test_helper'

class FundingsControllerTest < ActionController::TestCase
  setup do
    @funding = fundings(:one)
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fundings)
  end

  test "should get new" do
    get :new, transaction_id: @funding.transaction
    assert_response :success
  end

  test "should create funding" do
    assert_difference('Funding.count') do
      post :create, funding: { conference_id: @funding.conference_id, transaction_id: @funding.transaction_id }
    end

    assert_redirected_to transaction_path(assigns(:funding).transaction)
  end

  test "should show funding" do
    get :show, id: @funding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @funding
    assert_response :success
  end

  test "should update funding" do
    put :update, id: @funding, funding: { conference_id: @funding.conference_id, transaction_id: @funding.transaction_id }
    assert_redirected_to transaction_path(assigns(:funding).transaction)
  end

  test "should destroy funding" do
    assert_difference('Funding.count', -1) do
      delete :destroy, id: @funding
    end

    assert_redirected_to transaction_path(assigns(:funding).transaction)
  end
end
