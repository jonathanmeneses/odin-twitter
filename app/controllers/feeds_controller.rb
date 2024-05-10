class FeedsController < ApplicationController
  before_action :authenticate_user!

  def show
    # Fetch posts from the current user and users they are following
    user_ids = current_user.following.pluck(:id) << current_user.id
    @pagy, @posts = pagy(Post.where(user_id: user_ids).order(created_at: :desc))
  end
end
