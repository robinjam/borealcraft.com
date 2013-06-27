require 'digest/sha2'
require 'base62_encode'

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :screenshots, dependent: :destroy
  
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

  def self.generate_token(username, datestamp = Time.now.utc.strftime("%Y%m%d"))
    Digest::SHA512.hexdigest("#{username}#{SALT}#{datestamp}").to_i(16).base62_encode[0..6]
  end

  private

  SALT = BorealCraft::Application.config.secret_token

  def token_must_be_correct
    unless token == User.generate_token(username)
      errors.add(:token, "doesn't match your username (did you capitalize your username correctly?)")
    end
  end  
end
