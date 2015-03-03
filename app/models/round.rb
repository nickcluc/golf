class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :player_rounds

  validates :user_id, :course_id, :round_date, :tee_time, presence: true
end
