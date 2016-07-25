# Holes on a golf course
class Hole < ActiveRecord::Base
  belongs_to :course

  validates :number, :yardage, :handicap, :course, presence: true
  validates :number, :handicap, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 18
  }
  validates :yardage, numericality: { only_integer: true }

  def hardest?
    handicap == 1
  end

  def easiest?
    handicap == 18
  end

  def longest?
    course.holes.maximum(:yardage) == yardage
  end
end
