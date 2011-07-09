require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = { username: 'testuser', password: 'mypassword' }
  end
  
  test "should not be valid without username" do
    assert !User.new(@valid_attributes.except :username).valid?
    assert !User.new(@valid_attributes.merge username: '').valid?
  end

  test "should not be valid without password" do
    assert !User.new(@valid_attributes.except :password).valid?
    assert !User.new(@valid_attributes.merge password: '').valid?
  end

  test "should not be valid with duplicate username" do
    User.create!(@valid_attributes)
    u = User.new(@valid_attributes)
    assert !u.valid?
    assert u.errors.messages.include? :username
  end

  test "should not be valid if username is over 20 characters" do
    assert User.new(@valid_attributes.merge username: '12345678901234567890').valid?
    assert !User.new(@valid_attributes.merge username: '123456789012345678901').valid?
  end

  test "should be valid if username contains only alphanumeric characters and underscores" do
    assert User.new(@valid_attributes.merge username: 'Aa1_').valid?
    assert !User.new(@valid_attributes.merge username: 'some username').valid?
  end

  test "should not store password in database" do
    User.create!(@valid_attributes)
    assert_equal nil, User.last.password
  end

  test "should authenticate with correct username and password" do
    User.create!(@valid_attributes)
    u = User.find_by_username(@valid_attributes[:username])
    assert u && u.authenticate(@valid_attributes[:password])
  end

  test "should not authenticate with incorrect password" do
    User.create!(@valid_attributes)
    u = User.find_by_username(@valid_attributes[:username])
    assert u && !u.authenticate('incorrectpassword')
  end

  test "should not be admin by default" do
    assert !User.create(@valid_attributes).admin?
  end
end
