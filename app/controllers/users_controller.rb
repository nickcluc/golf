class UsersController < ApplicationController
  def index
    if params[:player_query].present?
      @users = User.search(params[:player_query])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @friendship = current_user.friendships.where("user_id = #{@user.id} OR friend_id = #{@user.id}").first
    if current_user
      @pending_friendships = Friendship.where(friend_id: current_user.id, accepted: false, ignored: false)
    end
  end
end
