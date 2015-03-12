class Tee < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  belongs_to :player_round

  validates :color, :slope, :rating, :user, :yardage, :course, presence: true
  validates :slope, :yardage, numericality: { only_integer: true }
  validates :rating, numericality: { only_float: true }
end
