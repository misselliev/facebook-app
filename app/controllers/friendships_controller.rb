# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Request sent'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to user_path(params[:friend_id])
  end

  def destroy
    friend_req = Friendship.find_by_id(params[:id])
    if friend_req.delete
      flash[:notice] = 'Request declined'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to user_path(params[:friend_id])
  end

  def update_status
    Friendship.confirm_friendship(params[:friend_request])
    redirect_to user_path(params[:id])
  end
end
