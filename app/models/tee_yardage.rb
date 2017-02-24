class TeeYardage < ActiveRecord::Base
  belongs_to :tee
  belongs_to :hole
end
