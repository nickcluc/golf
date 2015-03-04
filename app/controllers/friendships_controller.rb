class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Friend Request to #{User.find(params[:friend_id]).full_name} Sent!"
      redirect_to user_path(params[:friend_id])
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.update_attributes(accepted: true)
      flash[:notice] = "Friendship Accepted"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "An error has occurred"
      render "user/show"
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
