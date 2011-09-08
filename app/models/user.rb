require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :token
  attr_accessor :token
  
  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username
  
  validates_length_of :password, minimum: 6, unless: Proc.new { |u| u.password.blank? }

  validate :token_must_be_correct, on: :create

  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

  def self.generate_token(username)
    Digest::SHA512.hexdigest("#{username}#{SALT}")[0..4]
  end

  private

  SALT = "`@_0$mQ.x`BN^*C*`3WY93`LTk+>]y!L}15'5fZJpB}g&>1DzmW#O'=Rve_y9Z9"

  def token_must_be_correct
    unless token == User.generate_token(username)
      errors.add(:token, "doesn't match your username (did you capitalize your username correctly?)")
    end
  end  
end
