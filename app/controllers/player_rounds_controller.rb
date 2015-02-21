class PlayerRoundsController < ApplicationController
  def create
    @player_round = PlayerRound.new(player_round_params)
    @player_round.user = current_user
    @player_round.round = Round.find(params[:round_id])
    # binding.pry
    if @player_round.save
      flash[:notice] = "Score Saved Successfully!"
      redirect_to round_path(@player_round.round)
    else
      render "round#show"
    end
  end

  private

  def player_round_params
    params.require(:player_round).permit(
      :round_id,
      :user_id,
      :score,
      :hole_count,
      :tee_id
    )
  end
end
