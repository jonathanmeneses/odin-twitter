class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.limit(10)
  end

  def new
    @post = Post.new
  end

  def create

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post Created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
