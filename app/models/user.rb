class User < ActiveRecord::Base
  has_secure_password
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, maximum: 20
  validates_format_of :username, with: /^[a-z0-9_]+$/i
  
  validates_presence_of :password, on: :create
end
