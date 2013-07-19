require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "token is required on create but not on update" do
    refute_empty User.create.errors[:token]
    assert users(:notch).update_attributes(token: "incorrect token")
  end

  test "generation of unique token" do
    assert_equal "W2Nj4za", User.generate_token("foo", "")
    assert_equal "61I7FP6", User.generate_token("bar", "")
  end

  test "roles" do
    assert_equal [:member, :admin], users(:notch).roles
    assert_equal [:member], users(:jeb_).roles
  end
end
