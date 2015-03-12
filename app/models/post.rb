class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient,
    class_name: "User"

  validates :body, length: { maximum: 140,
    too_long: "%{count} characters is the maximum allowed" }
  validates :body, presence: true
  validates :user, presence: true
  validates :recipient, presence: true
end
