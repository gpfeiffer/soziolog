require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  setup do
    @label = labels(:one)
    @transaction = transactions(:one)
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:labels)
  end

  test "should get new" do
    get :new, transaction_id: @transaction
    assert_response :success
  end

  test "should create label" do
    assert_difference('Label.count') do
      post :create, label: { 
        amount: @label.amount, 
        category_id: @label.category_id, 
        transaction_id: @label.transaction_id 
      }
    end
    assert_redirected_to transaction_path(assigns(:label).transaction)
  end

  test "should show label" do
    get :show, id: @label
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @label
    assert_response :success
  end

  test "should update label" do
    put :update, id: @label, label: { 
      amount: @label.amount, 
      category_id: @label.category_id, 
      transaction_id: @label.transaction_id 
    }
    assert_redirected_to transaction_path(assigns(:label).transaction)
  end

  test "should destroy label" do
    assert_difference('Label.count', -1) do
      delete :destroy, id: @label
    end
    assert_redirected_to transaction_path(assigns(:label).transaction)
  end
end
