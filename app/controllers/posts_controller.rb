class PostsController < ApplicationController
  before_action :find_post, only: [:destroy]

  def find_post
    @post = Post.find(params[:id])
  end

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    authorize! :read, Post
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @like = Like.new
    render 'posts/detail_post'
  end

  def all_comments
    @post = Post.find(params[:post_id])
    render json: @post.comments
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }
  end

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    post = {
      title: post_params[:title],
      text: post_params[:text],
      comments_counter: 0,
      likes_counter: 0
    }
    @post = Post.new(post)
    @post.author = @user
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
