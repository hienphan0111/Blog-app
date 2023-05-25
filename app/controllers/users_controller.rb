class UsersController < ApplicationController
  def index
    
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    render 'users/profile'
  end
end
