class TeesController < ApplicationController
  before_action :authenticate_user!

  def create
    @tee = Tee.new(tee_params)
    @tee.user = current_user
    @tee.course = Course.find(params[:course_id])
    if @tee.save
      flash[:notice] = "Tee created successfully!"
      redirect_to course_path(@tee.course)
    else
      @course = @tee.course
      @new_tee = @tee
      render 'courses/show'
    end
  end

  private

  def tee_params
    params.require(:tee).permit(:name, :color, :slope, :rating, :yardage, :course_id, :user_id)
  end
end
