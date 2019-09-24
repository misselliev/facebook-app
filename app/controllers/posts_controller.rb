# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :access_post, only: :edit
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_index_path
    else
      render 'new'
    end
  end

  def index
    @posts = current_user.news_feed
  end

  def show
    @post = Post.find(params[:id])
    if current_user.friends.include? @post.author
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
    params.require(:post).permit(:content, :author_id)
  end
end
