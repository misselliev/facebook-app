# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create!(commenter_id: current_user.id, post_id: params[:id], content: params[:comment][:content])
    if @comment.save
      flash[:notice] = 'Comment created.'
      redirect_to post_path(params[:id])
    else
      flash[:alert] = 'Something went wrong.'
    end
  end
end
