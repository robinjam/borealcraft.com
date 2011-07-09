ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def as_admin
    user_id = session[:user_id]
    u = User.create!(username: 'test', password: 'testpass', admin: true)
    session[:user_id] = u.id
    yield
    session[:user_id] = user_id
  end
end
