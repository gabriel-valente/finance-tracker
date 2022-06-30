class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:friend])

    flash[:notice] = "You are now following #{@friendship.friend.full_name}."
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    
    flash[:notice] = "You unfollowed #{friendship.friend.full_name}."
    redirect_to friends_path
  end
end