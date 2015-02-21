class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :player_rounds
  has_many :users, through: :player_rounds
end
