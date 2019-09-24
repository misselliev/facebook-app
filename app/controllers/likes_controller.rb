# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authorized?
  def create
    @like = current_user.likes.build(post_id: params[:id])
    if params[:from] == 'user'
      redirecting_data(@like.save, params[:user])
    else
      redirecting_data(@like.save)
    end
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:id])
    if params[:from] == 'user'
      redirecting_data(@like.delete, params[:user])
    else
      redirecting_data(@like.delete)
    end
  end

  private

  def redirecting_data(param, user = nil)
    if param
      redirect_to posts_index_path if params[:from] == 'index'
      redirect_to post_path if params[:from] == 'show'
      redirect_to user_path(user) if params[:from] == 'user'
    else
      flash[:alert] = 'Something went wrong'
    end
  end
end
