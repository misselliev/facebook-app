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
    @joined_at = @user.created_at.year
    @num_friends = @user.friendships.confirmed.count
    @name = "#{@user.name} #{@user.lastname}"
    @email = @user.email
  end

  def create_friendship
    self.confirm_friendship?(friend_request=nil)
  end


  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password)
  end

end
