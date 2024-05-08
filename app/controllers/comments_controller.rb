class CommentsController < ApplicationController
  before_action :set_post, :authenticate_user!

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.turbo_stream {
          flash.now[:notice] = "Comment Saved"
          render turbo_stream: [
            turbo_stream.replace(@post, partial: 'posts/post', locals: { post: @post }),
            turbo_stream.replace("flash", partial: "layouts/flash")
          ]
        }
        format.html { redirect_back(fallback_location: root_path, notice: "Comment Saved") }
      end
    else
      flash.now[:alert] = "Comment not Saved"
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash")
        }
        format.html { redirect_back(fallback_location: root_path, alert: "Comment not Saved") }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
