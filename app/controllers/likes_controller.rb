class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:create, :destroy]

  def create
    puts @post.inspect
    like = @post.likes.build(user: current_user)
    if like.save
      redirect_back(fallback_location: root_path)
    else
      puts like.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end


  end

  def destroy
    @post.likes.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
