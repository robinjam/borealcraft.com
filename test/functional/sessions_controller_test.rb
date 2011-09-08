require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = Factory(:user, password: "test_password")
  end
  
  test "should log in user" do
    post :create, { username: @user.username, password: "test_password" }
    assert_equal @user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test "should not log in user with incorrect credentials" do
    post :create, { username: @user.username, password: "incorrect_password" }
    assert session[:user_id].nil?
    assert_redirected_to root_path
  end

  test "should log out user" do
    delete :destroy, nil, user_id: @user.id
    assert session[:user_id].nil?
    assert_redirected_to root_path
  end
end
