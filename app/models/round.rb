class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :player_rounds

end
