require 'test_helper'

class DoctoratesControllerTest < ActionController::TestCase
  setup do
    @doctorate = doctorates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doctorates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doctorate" do
    assert_difference('Doctorate.count') do
      post :create, doctorate: { advisor: @doctorate.advisor, first: @doctorate.first, genealogy_id: @doctorate.genealogy_id, last: @doctorate.last, thesis: @doctorate.thesis, title: @doctorate.title, university: @doctorate.university, year: @doctorate.year }
    end

    assert_redirected_to doctorate_path(assigns(:doctorate))
  end

  test "should show doctorate" do
    get :show, id: @doctorate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doctorate
    assert_response :success
  end

  test "should update doctorate" do
    put :update, id: @doctorate, doctorate: { advisor: @doctorate.advisor, first: @doctorate.first, genealogy_id: @doctorate.genealogy_id, last: @doctorate.last, thesis: @doctorate.thesis, title: @doctorate.title, university: @doctorate.university, year: @doctorate.year }
    assert_redirected_to doctorate_path(assigns(:doctorate))
  end

  test "should destroy doctorate" do
    assert_difference('Doctorate.count', -1) do
      delete :destroy, id: @doctorate
    end

    assert_redirected_to doctorates_path
  end
end
