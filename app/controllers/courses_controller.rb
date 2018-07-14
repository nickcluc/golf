class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @courses = Course.all.order(:name).group_by{|c| c.name[0]} || []
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.save
      flash[:notice] = "Course created successfully!"
      if request.path == user_courses_path
        @round = Round.new
        redirect_to user_path @course.user
      else
        redirect_to course_path(@course)
      end
    else
      flash[:notice] = "Error(s) prevented course from being created"
      if request.path == user_courses_path
        render partial: 'courses/new'
      else
        render :new
      end
    end
  end

  def show
    @course = Course.find(params[:id])
    @location = [[@course.latitude, @course.longitude]]
    @new_tee = Tee.new
    @holes = @course.holes.order('number ASC')
    @front_nine = @holes.limit(9)
    @back_nine = @holes.offset(9).limit(9)
  end

  private

  def course_params
    params.require(:course).permit(
      :name,
      :street_address,
      :city,
      :state,
      :zip_code,
      :user_id,
      :phone
    )
  end
end
