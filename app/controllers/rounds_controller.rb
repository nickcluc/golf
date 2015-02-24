class RoundsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
    @round.user = current_user
    @round.course ||= @player_round.tee.course
    if @round.save
      flash[:notice] = "Round Created Successfully!"
      redirect_to round_path(@round)
    else
      render :new
    end
  end

  def show
    @round = Round.find(params[:id])
    @player_round = PlayerRound.new
    @course_tees = @round.course.tees
    @location = [[@round.course.latitude, @round.course.longitude]]
  end

  private

  def round_params
    params.require(:round).permit(:round_date, :tee_time, :course_id, :user_id)
  end
end
