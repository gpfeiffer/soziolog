require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:one)
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { 
        address: @member.address, 
        bulletin: @member.bulletin,
        comment: @member.comment, 
        email: @member.email, 
        forename: @member.forename, 
        number: '99999', 
        status: @member.status, 
        surname: @member.surname, 
        title: @member.title 
      }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    put :update, id: @member, member: { 
      address: @member.address, 
        bulletin: @member.bulletin,
      comment: @member.comment, 
      email: @member.email, 
      forename: @member.forename, 
      number: @member.number, 
      status: @member.status, 
      surname: @member.surname, 
      title: @member.title 
    }
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end
