class Message < ActiveRecord::Base
  belongs_to :user

  # With this we help retrieve post from the newest to the oldest
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 160 }
end
