class Tee < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  belongs_to :player_round
end
