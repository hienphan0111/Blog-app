class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    render 'users/profile'
  end

  def posts
    user = User.find(params[:user_id])
    render json: user.posts
  end
end
