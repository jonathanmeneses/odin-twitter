class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:create, :destroy]

  def create
    puts @post.inspect
    like = @post.likes.build(user: current_user)
    if like.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.replace(@post, partial: 'posts/post', locals: { post: @post }),
          ]
        }
        format.html { redirect_back(fallback_location: root_path, notice: "Like Added") }
      end
    else
      flash.now[:alert] = "Like not able to be added"
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash")
        }
        format.html { redirect_back(fallback_location: root_path, alert: "Like not able to be added")}
      end
    end


  end

  def destroy
    @post.likes.find(params[:id]).destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(@post, partial: 'posts/post', locals: { post: @post })
      }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
