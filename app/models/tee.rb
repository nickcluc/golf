class Tee < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  belongs_to :player_round

  validates :color, :slope, :rating, :yardage, :course_id, presence: true
  validates :slope, :yardage, numericality: { only_integer: true }
end
