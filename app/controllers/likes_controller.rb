class LikesController < ApplicationController
  before_action :authorized?
  def create
    @like = current_user.likes.build(post_id: params[:id])
    if @like.save
      redirect_to posts_index_path if params[:from] === 'index'
      redirect_to post_path if params[:from] === 'show'
    else
      flash[:alert] = "Something went wrong"
    end
  end
end
