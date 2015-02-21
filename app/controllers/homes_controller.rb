class HomesController < ApplicationController
  def index
    @last_three_rounds = PlayerRound.last(3)
  end
end
