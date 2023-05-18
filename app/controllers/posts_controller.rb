class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @like = Like.new
    render 'posts/detail_post'
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
