class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = 'name'
    # @user = User.find(params[:id])
    render 'users/profile'
  end
end
