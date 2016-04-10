class User < ActiveRecord::Base
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, :user_name, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :password,
      :length => { :minimum => 5 }
  validates_confirmation_of :password

  # We ensure the emails have the same format to mantain consistency in the DB
  before_save :upcase_email

  private
  def upcase_email
    self.email = email.upcase
  end
end
