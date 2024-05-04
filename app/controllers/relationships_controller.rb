class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.following << @user
  end

  def destroy
    @relationship = current_user.active_relationships.find(params[:id])
    @user = @relationship.followed
    current_user.following.delete(@user)
  end

end
