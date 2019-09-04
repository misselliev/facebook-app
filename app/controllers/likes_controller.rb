class LikesController < ApplicationController
  before_action :authorized?
  def create
    @like = current_user.likes.build(post_id: params[:id])
    redirecting_data(@like.save)

  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:id])
    redirecting_data(@like.delete)
  end

  private 

  def redirecting_data(param)
    if param
      redirect_to posts_index_path if params[:from] === 'index'
      redirect_to post_path if params[:from] === 'show'
    else
      flash[:alert] = "Something went wrong"
    end
  end

end
