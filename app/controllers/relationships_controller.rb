class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @followers = @user.followers
    @following = @user.following
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.following << @user
      redirect_back(fallback_location: root_path, notice: "User Followed!")
    else
      redirect_back(fallback_location: root_path, alert: "User not followed!") # Add an error message when comment fails to save
    end
  end

  def destroy
    # debugger
    user_to_delete = User.find(params[:user_id])
    if current_user.following.delete(user_to_delete)
      redirect_back(fallback_location: root_path, notice: "User Unfollowed!")
    else
      redirect_back(fallback_location: root_path, alert: "User not Unfollowed!") # Add an error message when comment fails to save
    end
  end

end
