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

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password)
  end

end
