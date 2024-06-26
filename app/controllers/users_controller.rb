class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @users = User.all
  end

  def show
     @user = User.find(params[:id])
     @pagy, @posts = pagy(@user.posts)
  end
end
