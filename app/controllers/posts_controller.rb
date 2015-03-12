class PostsController < ApplicationController
  def index
  end

  def create
    @post = Post.new(post_params)
    @post.recipient = User.find(params[:user_id])
    @post.user = current_user
    if @post.save
      redirect_to user_path(@post.recipient)
    else
      @user = User.find(params[:user_id])
      @round = Round.new
      @course = Course.new
      @wall_posts = Post.where(recipient: @user)
      render "users/show"
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :recipient_id, :body)
  end
end
