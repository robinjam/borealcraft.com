require 'digest/sha2'
require 'base62_encode'

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :screenshots, dependent: :destroy
  
  attr_accessible :username, :password, :password_confirmation, :token
  attr_accessor :token
  
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, unless: -> (u) { u.password.blank? }
  validate -> {
    unless token == User.generate_token(username)
      errors.add(:token, "doesn't match your username (did you capitalize your username correctly?)")
    end
  }, on: :create

  def self.generate_token(username, datestamp = Time.now.utc.strftime("%Y%m%d"))
    Digest::SHA512.hexdigest("#{username}#{Rails.configuration.secret_token}#{datestamp}").to_i(16).base62_encode[0..6]
  end

  def roles
    [:member, (:admin if admin?)].compact
  end 
end
