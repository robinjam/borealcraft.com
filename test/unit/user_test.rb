require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "users are not admin by default" do
    assert !Factory.build(:user).admin?
  end

  test "username is required" do
    assert !Factory.build(:user, username: nil).valid?
  end

  test "password must be a minimum of 6 characters long" do
    assert Factory.build(:user, password: '123456').valid?
    assert !Factory.build(:user, password: '12345').valid?
  end

  test "username must be unique" do
    u = Factory(:user)
    assert !Factory.build(:user, username: u.username).valid?
  end

  test "token must be correct on create but must not be required on update" do
    user = Factory.build(:user, token: "incorrect")
    assert !user.valid?
    user.token = User.generate_token(user.username)
    assert user.save
    user.token = nil
    assert user.save
  end

  test "only mass assignment of username, password and password_confirmation is allowed" do
    u = User.new(username: 'username', password: 'password', password_confirmation: 'password_confirmation', admin: true, password_digest: 'password_digest', created_at: Time.now, updated_at: Time.now)
    assert_equal "username", u.username
    assert_equal "password", u.password
    assert_equal "password_confirmation", u.password_confirmation
    assert !u.admin?
    assert_not_equal "password_digest", u.password_digest
    assert_nil u.created_at
    assert_nil u.updated_at
  end

  test "user is authenticated given correct username and password" do
    u = Factory(:user)
    assert_equal u, User.authenticate(u.username, u.password)
    assert !User.authenticate(u.username, "Incorrect password")
  end

  test "generation of unique token" do
    assert_equal "41b85", User.generate_token("foo")
    assert_equal "ac4ec", User.generate_token("bar")
  end

  test "destroys all associated comments on delete" do
    user = Factory(:user)
    comment = Factory(:comment, user: user)
    user.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end

  test "destroys all associated screenshots on delete" do
    user = Factory(:user)
    screenshot = Factory(:screenshot, user: user)
    user.destroy
    assert_nil Screenshot.find_by_id(screenshot.id), "Screenshot should have been deleted"
  end
end
