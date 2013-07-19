require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "users are not admin by default" do
    assert !FactoryGirl.build(:user).admin?
  end

  test "username is required" do
    assert !FactoryGirl.build(:user, username: nil).valid?
  end

  test "password must be a minimum of 6 characters long" do
    assert FactoryGirl.build(:user, password: '123456').valid?
    assert !FactoryGirl.build(:user, password: '12345').valid?
  end

  test "username must be unique" do
    u = FactoryGirl.create(:user)
    assert !FactoryGirl.build(:user, username: u.username).valid?
  end

  test "token is required on create but not on update" do
    refute_empty User.create.errors[:token]
    assert users(:notch).update_attributes(token: "incorrect token")
  end

  test "only mass assignment of username, password and password_confirmation is allowed" do
    assert_attributes_accessible User, [:username, :password, :password_confirmation]
    assert_attributes_protected User, [:admin, :password_digest, :created_at, :updated_at]
  end

  test "generation of unique token" do
    assert_equal "W2Nj4za", User.generate_token("foo", "")
    assert_equal "61I7FP6", User.generate_token("bar", "")
  end

  test "destroys all associated comments on delete" do
    user = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:comment, user: user)
    user.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end

  test "destroys all associated screenshots on delete" do
    user = FactoryGirl.create(:user)
    screenshot = FactoryGirl.create(:screenshot, user: user)
    user.destroy
    assert_nil Screenshot.find_by_id(screenshot.id), "Screenshot should have been deleted"
  end

  test "roles" do
    assert_equal [:member, :admin], users(:notch).roles
    assert_equal [:member], users(:jeb_).roles
  end
end
