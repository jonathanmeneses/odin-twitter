class CommentsController < ApplicationController
  before_action :set_post, :authenticate_user!

  def new
    @comment = @post.comments.build
  end

  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment saved successfully'
    else
      redirect_to @post, alert: "Comment Not Saved"
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
