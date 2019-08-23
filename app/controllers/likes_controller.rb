class LikesController < ApplicationController
  before_action :authorized?
  def create
    @like = current_user.likes.build(post_id: params[:id])
    if @like.save
      redirect_to posts_index_path
    else
      flash[:alert] = "Something went wrong"
    end
  end
end
