require 'rails_helper'
require 'capybara'

RSpec.describe 'User index page:', type: :system do
  before(:each) do
    @user1 = User.create(name: 'User 1', photo: 'http://localhost:3000/anything.jpg', bio: 'User info', posts_counter: 0)
    @post1 = Post.create(title: 'post one', text: 'post one text', author: @user1, comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(title: 'post two', text: 'post two text', author: @user1, comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(title: 'post three', text: 'post three text', author: @user1, comments_counter: 0, likes_counter: 0)
    @post4 = Post.create(title: 'post four', text: 'post four text', author: @user1, comments_counter: 0,likes_counter: 0)
  end

  # User index page

  describe 'User index page' do
    scenario 'I can see the username of all other users' do
      visit users_path
      expect(page).to have_content(@user1.name)
    end
    scenario 'I can see the profile picture for each user.s' do
      visit users_path
      expect(@user1.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
    end
    scenario 'I can see the number of posts each user has written.' do
      visit users_path
      expect(page).to have_content(@user1.posts_counter)
    end
    scenario 'When I click on a user, I am redirected to that user show page' do
      visit users_path
      click_link(@user1.name)
      expect(page).to have_current_path(user_path(@user1.id))
    end
  end

  # User show page
  describe 'User show page' do
    scenario 'I can see the user profile picture' do
      visit user_path(@user1.id)
      expect(@user1.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
    end
    scenario 'I can see the users username.' do
      visit user_path(@user1.id)
      expect(page).to have_content(@user1.name)
    end
    scenario 'I can see the number of posts the user has written.' do
      visit user_path(@user1.id)
      expect(page).to have_content(@user1.posts_counter)
    end
    scenario 'I can see the users bio' do
      visit user_path(@user1.id)
      expect(page).to have_content(@user1.bio)
    end
    scenario 'I can see the users first 3 posts' do
      visit user_path(@user1.id)
      expect(page).to have_content(@user1.posts[0].title)
      expect(page).to have_content(@user1.posts[1].title)
      expect(page).to have_content(@user1.posts[2].title)
    end
    scenario 'I can see a button that lets me view all of a users posts' do
      visit user_path(@user1.id)
      expect(page).to have_button('See all posts')
    end
    scenario 'When I click a users post, it redirects me to that posts show page' do
      visit user_path(@user1.id)
      click_link(@user1.posts[0].title)
      expect(page).to have_current_path(user_post_path(@user1.id, @user1.posts[0].id))
    end
    scenario 'When I click the see all posts button, it redirects me to the users posts index page' do
      visit user_path(@user1.id)
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user1.id))
    end
  end
end