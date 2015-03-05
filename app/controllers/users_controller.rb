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
    if current_user
      @pending_friendships = Friendship.where(friend_id: current_user.id, accepted: false)
    end
  end
end
