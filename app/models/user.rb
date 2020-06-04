class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :first_name, :last_name, :password, 
    message: "field is required"
  validates :password, length: {minimum: 8}
  validates_uniqueness_of  :email, case_sensitive: false
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  def self.authenticate_with_credentials(email, pass)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(pass) 
    user
    else
      return nil
    end
  end
end
