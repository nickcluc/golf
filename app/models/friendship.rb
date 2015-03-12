class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.accepted
    where(accepted: true)
  end
end
