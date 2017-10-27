class User < ApplicationRecord
  validates :username, uniqueness: true
  validates :username, :email, :password_digest, presence: true
  after_initialize :ensure_session_token
  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)

  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    if BCrypt::Password.new(user.password_digest).is_password?(password)
      user
    else
      nil
    end
  end

  def self.create(params)
    user = User.new
    user.password = params[:password]
    user.email = params[:username]
    user.username = params[:username]
    user.save
    user 
  end




end
