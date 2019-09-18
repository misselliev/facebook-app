class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @is_a_friend = current_user.friendships.find_by_friend_id(@user)
    @diff_profile_new_friend = @user != current_user && @is_a_friend.nil?
    @pending_requests = Friendship.pending_with_friend_id(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password)
  end

end
