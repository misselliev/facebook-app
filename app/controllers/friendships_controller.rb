class FriendshipsController < ApplicationController
  def create
    unless current_user.friendships.find_by(user_id: current_user.id, friend_id: params[:friend_id], confirmed: false)
      @friendship = current_user.friendship.build(friend_id: params[:friend_id])
      if @friendship.save
        flash[:notice] = 'Request sent'
      end
    end
  end

  def update_status
    byebug
    Friendship.confirm_friendship?(params[:friend_request], params[:status])
  end
end
