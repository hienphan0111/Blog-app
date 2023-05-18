class LikesController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new
    @like.user = @user
    @like.post = @post
    @like.save
    redirect_to user_post_path(@user, @post)
  end
end
