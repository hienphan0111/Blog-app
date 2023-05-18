class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.first
    @posts = @user.posts
    render 'users/profile'
  end
end
