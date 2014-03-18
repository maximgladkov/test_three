require 'digest/sha1'

class User < ActiveRecord::Base

  attr_accessor :password, :password_confirmation

  validates :name, :email, :password, :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  before_save :encrypt_password
  before_save :generate_authentication_token

  def authorizable?(params)
    !new_record? && name == params[:name] && email == params[:email] && encrypted_password == User.encrypt_password(params[:password])
  end

  def encrypt_password
    self.encrypted_password = User.encrypt_password(password)
  end

  def as_json(options = {})
    super only: [ :id, :name, :email, :authentication_token]
  end

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest(password)
  end

  private

  def generate_authentication_token
    self.authentication_token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

end
