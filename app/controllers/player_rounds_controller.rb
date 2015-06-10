class PlayerRoundsController < ApplicationController
  before_action :authenticate_user!

  def create
    @player_round = PlayerRound.new(player_round_params)
    @player_round.user = current_user
    @player_round.round = Round.find(params[:round_id])
    if params[:player_round][:user_id]
      @player_round.user = User.find(params[:player_round][:user_id])
    end
    if @player_round.save
      flash[:notice] = "Score Saved Successfully!"
      redirect_to round_path(@player_round.round)
    else
      @round = Round.find(params[:round_id])
      @player_round = PlayerRound.new
      @course_tees = @round.course.tees
      @location = [[@round.course.latitude, @round.course.longitude]]
      render "rounds/show"
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
