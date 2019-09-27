# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def index
    @users = User.all
    @post = Post.new
    @pending_requests = current_user.inverted_pending
  end

  def show
    @post = Post.new
    @user = User.find_by_id(params[:id])
    @is_pending = current_user.friendships.is_a_pending(@user).exists?
    @is_incoming = @user.friendships.is_a_pending(current_user).exists?
    @same_profile = @user == current_user
    @already_friends = current_user.friendships.is_my_friend?(@user).exists?
    @pending_requests = current_user.inverted_pending
  end

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password)
  end
end
