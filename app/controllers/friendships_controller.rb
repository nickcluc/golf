class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Friend Request to #{User.find(params[:friend_id]).full_name} Sent!"
      redirect_to user_path(params[:friend_id])
    else
      @user = User.find(params[:friend_id])
      render "users/show"
    end
  end

  def index
    @user = User.find(params[:user_id])
    @friendship = current_user.friendships.where("user_id = #{@user.id} OR friend_id = #{@user.id}").first
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if current_user == @friendship.user
      @unfriended = @friendship.friend
    elsif current_user == @friendship.friend
      @unfriended = @friendship.user
    end
    @inverse_friendship = Friendship.find_by(user_id: @friendship.friend_id, friend_id: @friendship.user_id, accepted:true)
    if @friendship.destroy
      @inverse_friendship.destroy
      flash[:notice] = "You are no longer friends with #{@unfriended.full_name}"
      redirect_to user_path(current_user)
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if params[:accepted]
      @friendship.update_attributes(accepted: params[:accepted])
      Friendship.create(user: @friendship.friend, friend_id: @friendship.user_id, accepted: true)
      flash[:notice] = "Friendship Accepted"
      redirect_to user_path(current_user)
    elsif params[:ignored]
      @friendship.update_attributes(ignored: params[:ignored])
      flash[:notice] = "Friend Request From #{@friendship.user.full_name} Ignored"
      redirect_to user_path(current_user)
    end
  end
end
