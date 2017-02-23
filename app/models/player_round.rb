class PlayerRound < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  belongs_to :tee
  belongs_to :course

  validates :user_id, :round_id, :score, :hole_count, :tee_id, presence: true
  validates :score, :hole_count, numericality: { only_integer: true }
end
