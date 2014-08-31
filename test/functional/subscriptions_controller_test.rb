require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @subscription = subscriptions(:one)
    @transaction = transactions(:one)
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new, transaction_id: @transaction
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post :create, subscription: { 
        member_id: @subscription.member_id, 
        paid_on: @subscription.paid_on, 
        payment: @subscription.payment, 
        transaction_id: @subscription.transaction_id, 
        value: @subscription.value, 
        currency: @subscription.currency, 
        year: @subscription.year 
      }
    end
    assert_redirected_to transaction_path(assigns(:subscription).transaction)
  end

  test "should show subscription" do
    get :show, id: @subscription
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription
    assert_response :success
  end

  test "should update subscription" do
    put :update, id: @subscription, subscription: { member_id: @subscription.member_id, paid_on: @subscription.paid_on, payment: @subscription.payment, transaction_id: @subscription.transaction_id, value: @subscription.value, year: @subscription.year }
    assert_redirected_to transaction_path(assigns(:subscription).transaction)
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription
    end
    assert_redirected_to transaction_path(assigns(:subscription).transaction)
  end
end
