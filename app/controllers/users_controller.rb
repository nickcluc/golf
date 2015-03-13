class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:player_query].present?
      @users = User.search(params[:player_query])
    else
      @users = User.all
    end
  end

  def show
    @user = User.includes(:player_rounds).find(params[:id])
    @round = Round.new
    @course = Course.new
    @post = Post.new
    @wall_posts = Post.where(recipient: @user)
    @friendship = current_user.friendships.where("user_id = #{@user.id} OR friend_id = #{@user.id}").first
    if current_user
      @pending_friendships = Friendship.where(friend_id: current_user.id, accepted: false, ignored: false)
    end
  end
end
