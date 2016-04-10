class User < ActiveRecord::Base
  has_secure_password

  # With the dependent option we avoid having messages without user, if it
  # decide to, leave our awesome social network :(
  has_many :messages, dependent: :destroy

  # Social Associations
  has_many :active_relationships, class_name: 'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, :user_name, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :password,
      :length => { :minimum => 5 }
  validates_confirmation_of :password

  # We ensure the emails have the same format to mantain consistency in the DB
  before_save :upcase_email

  def create_following_relationship(user)
    active_relationships.create(followed_id: user.id)
  end

  def destroy_following_relationship(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  private
  def upcase_email
    self.email = email.upcase
  end
end
