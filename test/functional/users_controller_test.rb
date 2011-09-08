require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: Factory.attributes_for(:user)
    end

    assert_not_nil assigns(:user)
    assert_redirected_to root_path
  end
end
