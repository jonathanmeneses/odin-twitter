class PostsController < ApplicationController
  before_action :authenticate_user!


  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = Post.new
  end

  def create

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post Created"
    else
      debugger
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def likes
    @post = Post.find(params[:id])
    @likes = @post.likes.includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :image_url)
  end

end
