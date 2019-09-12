class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Request sent'
      redirect_to user_path(params[:friend_id])
    else
      flash[:alert] = 'Something went wrong'
    end
  end

  def destroy
    friend_req = Friendship.find_by_id(params[:id])
    if friend_req.delete
      flash[:notice] = 'Request declined'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to user_path(params[:id])
  end

  def update_status
    Friendship.confirm_friendship(params[:friend_request], params[:status])
    redirect_to user_path(params[:id])
  end

end
