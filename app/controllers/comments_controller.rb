class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end

  def new
    @user = current_user
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post
    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def api_create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(api_comment_params.merge(user: current_user))
    render json: @comment
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    @comment.destroy

    redirect_to user_post_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def api_comment_params
    params.require(:comment).permit(:text)
  end
end
