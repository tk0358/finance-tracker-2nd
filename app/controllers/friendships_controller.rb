class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend])
    Friendship.create(user_id: current_user.id, friend_id: friend.id)
    redirect_to my_friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.destroy
    redirect_to my_friends_path
  end
end