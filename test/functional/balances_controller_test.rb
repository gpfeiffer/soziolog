require 'test_helper'

class BalancesControllerTest < ActionController::TestCase
  setup do
    @balance = balances(:two)
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:balances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create balance" do
    assert_difference('Balance.count') do
      post :create, balance: { 
        balance: @balance.balance - 100, 
        date: @balance.date + 1, 
        previous_id: @balance.id 
      }
    end

    assert_redirected_to balance_path(assigns(:balance))
  end

  test "should show balance" do
    get :show, id: @balance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @balance
    assert_response :success
  end

  test "should update balance" do
    put :update, id: @balance, balance: { balance: @balance.balance, date: @balance.date, previous_id: @balance.previous_id }
    assert_redirected_to balance_path(assigns(:balance))
  end

  test "should destroy balance" do
    assert_difference('Balance.count', -1) do
      delete :destroy, id: @balance
    end

    assert_redirected_to balances_path
  end
end
