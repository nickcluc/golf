class Tee < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  belongs_to :player_round
  has_many :tee_yardages

  validates :color, :slope, :rating, :user, :yardage, :course, presence: true
  validates :slope, :yardage, numericality: { only_integer: true }
  validates :rating, numericality: { only_float: true }

  def front_nine
    tee_yardages.includes(:hole).order('holes.number ASC').limit(9)
  end

  def back_nine
    tee_yardages.includes(:hole).order('holes.number ASC').offset(9).limit(9)
  end
end
