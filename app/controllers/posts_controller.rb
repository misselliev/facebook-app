# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :access_post, only: :edit
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.update(friend_id: params[:friend_id].to_i)
    if @post.save
      redirecting_data(params[:from], params[:friend_id].to_i) if params[:from] == 'user'
      redirecting_data(params[:from]) if params[:from] == 'index'
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def index
    @posts = current_user.news_feed
    @post = Post.new
    @pending_requests = current_user.inverted_pending
  end

  def show
    @post = Post.find(params[:id])
    if current_user.friends.include?(@post.author) || current_user == @post.author
      @comment = Comment.new
      @index_comments = @post.comments.all.recent_comments
    else
      flash[:alert] = 'This post is inaccessible from your user.'
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = 'Post updated'
      redirect_to post_path(params[:id])
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post deleted'
    else
      flash[:alert] = 'Post cannot be deleted'
    end
    redirect_to posts_index_path
  end

  private

  def access_post
    post = current_user.posts.find_by(id: params[:id])
    if post.nil?
      flash[:alert] = 'You are not authorized to do this'
      render post_path(params[:id])
    else
      @post
    end
  end

  def authorized_viewer(user)
    current_user.friends.include?(user)
  end

  def post_params
    params.require(:post).permit(:content, :author_id, :friend_id)
  end

  def redirecting_data(from, user = nil)
    redirect_to posts_index_path if from == 'index'
    redirect_to user_path(user) if from == 'user'
  end
end
