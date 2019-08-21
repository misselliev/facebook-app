class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    byebug
    if @post.save
      redirect_to posts_index_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
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

  def post_params
    params.require(:post).permit(:content, :author_id)
  end

end
