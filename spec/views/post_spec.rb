require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe 'User post index page:', type: :system do
  before(:each) do
    @user1 = User.create(name: 'User1', photo: 'http://localhost:3000/anything.jpg', bio: 'User Info', posts_counter: 0)
    @post1 = Post.create(title: 'post one', text: 'post one text', author: @user1, comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(title: 'post two', text: 'post two text', author: @user1, comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(title: 'post three', text: 'post three text', author: @user1, comments_counter: 0, likes_counter: 0)
    @post4 = Post.create(title: 'post four', text: 'post four text', author: @user1, comments_counter: 0, likes_counter: 0)
    @comment1 = Comment.create(text: 'comment one', user: @user1, post: @post1)
    @comment2 = Comment.create(text: 'comment two', user: @user1, post: @post1)
    @comment3 = Comment.create(text: 'comment three', user: @user1, post: @post1)
    @comment4 = Comment.create(text: 'comment four', user: @user1, post: @post1)
    @comment5 = Comment.create(text: 'comment five', user: @user1, post: @post1)
    @like1 = Like.create(user: @user1, post: @post1)
  end

  describe 'User post index page' do
    scenario 'I can see the users profile picture.' do
      visit user_posts_path(@user1.id)
      expect(@user1.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
    end
    scenario 'I can see the users name.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@user1.name)
    end
    scenario 'I can see the number of posts the user has written.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@user1.posts.count)
    end
    scenario 'I can see a posts title.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('post one')
    end
    scenario 'I can see some of the posts body.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@post1.title)
    end
    scenario 'I can see the first comments on a post.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@post1.comments[0].text)
    end
    scenario 'I can see how many comments a post has.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@post1.comments.count)
    end
    scenario 'I can see how many likes a post has.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@post1.likes.count)
    end
    scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_button('Pagination')
    end
    scenario 'When I click on a post, it redirects me to that posts show page.' do
      visit user_posts_path(@user1.id)
      click_link('post one')
      expect(page).to have_current_path(user_post_path(@user1.id, @user1.posts.first.id))
    end
  end

  # Post show page
  describe 'Post show page' do
    scenario 'I can see the posts title.' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@post1.title)
    end
    scenario 'I can see who wrote the post' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@post1.author.name)
    end
    scenario 'I can see how many comments it has.' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@post1.comments.count)
    end
    scenario 'I can see how many likes it has.' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@post1.likes.count)
    end
    scenario ' I can see the post body.' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@post1.text)
    end
    scenario 'I can see the username of each commentor.' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@comment1.user.name)
      expect(page).to have_content(@comment2.user.name)
      expect(page).to have_content(@comment3.user.name)
      expect(page).to have_content(@comment4.user.name)
      expect(page).to have_content(@comment5.user.name)
    end
    scenario 'I can see the body of each comment.' do
      visit user_post_path(@user1.id, @post1.id)
      expect(page).to have_content(@user1.posts.first.comments.first.text)
      expect(page).to have_content(@user1.posts.first.comments.second.text)
      expect(page).to have_content(@user1.posts.first.comments.third.text)
      expect(page).to have_content(@user1.posts.first.comments.fourth.text)
      expect(page).to have_content(@user1.posts.first.comments.fifth.text)
    end
  end
end
