require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @attrs = { username: 'testuser', password: 'testpassword' }
    @user = User.create!(@attrs)
  end
  
  test "should log in user" do
    post :create, @attrs
    assert_equal @user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test "should not log in user with incorrect credentials" do
    post :create, @attrs.merge(password: 'incorrectpassword')
    assert session[:user_id].nil?
    assert_redirected_to root_path
  end

  test "should log out user" do
    delete :destroy, nil, user_id: @user.id
    assert session[:user_id].nil?
    assert_redirected_to root_path
  end
end
