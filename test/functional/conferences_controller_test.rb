require 'test_helper'

class ConferencesControllerTest < ActionController::TestCase
  setup do
    @conference = conferences(:one)
    @user = users(:me)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conference" do
    assert_difference('Conference.count') do
      post :create, conference: { applicant: @conference.applicant, call: @conference.call, date: @conference.date, description: @conference.description, funding: @conference.funding, host: @conference.host, name: @conference.name }
    end

    assert_redirected_to conference_path(assigns(:conference))
  end

  test "should show conference" do
    get :show, id: @conference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conference
    assert_response :success
  end

  test "should update conference" do
    put :update, id: @conference, conference: { applicant: @conference.applicant, call: @conference.call, date: @conference.date, description: @conference.description, funding: @conference.funding, host: @conference.host, name: @conference.name }
    assert_redirected_to conference_path(assigns(:conference))
  end

  test "should destroy conference" do
    assert_difference('Conference.count', -1) do
      delete :destroy, id: @conference
    end

    assert_redirected_to conferences_path
  end
end
