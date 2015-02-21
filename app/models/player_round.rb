class PlayerRound < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  belongs_to :tee
end
