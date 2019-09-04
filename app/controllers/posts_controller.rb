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
    @posts = Post.all.recent_posts
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @index_comments = @post.comments.all.recent_comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to post_path(params[:id])
    else
      render 'edit'
    end
    
  end

  private

  def access_post
    post = current_user.posts.find_by(id: params[:id])
    if post
      redirect_to edit_post_path(post)
    else
      flash[:alert] = "You are not authorized to do this" 
      redirect_to post_path(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:content, :author_id)
  end

end
