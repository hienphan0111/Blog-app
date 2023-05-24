require 'rails_helper'

RSpec.describe 'User show', type: :system do

  let(:user1) { User.create(name: 'User1', photo: 'http://', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', posts_counter: 0) }
  let(:user2) { User.create(name: 'User2', photo: 'http://', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', posts_counter: 0) }
  let(:post1) { Post.create(title: "First post", text: "This is the first post", author_id: user1.id) }
  let(:post2) { Post.create(title: "Second post", text: "This is the second post", author_id: user1.id) }
  let(:post3) { Post.create(title: "Third post", text: "This is the third post", author_id: user1.id) }

  describe 'User index page' do
    it 'shows the right content' do
      visit users_path

      expect(page).to have_content('User1')
      expect(page).to have_content('User2')

      expect(page).to have_css("img[src*='http://']")
      expect(page).to have_content("#{user1.name} - #{user1.posts.count} posts")
      expect(page).to have_content("#{user2.name} - #{user2.posts.count} posts")

      # This is added assuming anchor tag with path exists
      click_link 'User1'

      expect(current_path).to eq(user_path(user1))
    end
  end

  describe 'User show page' do
    let!(:user) { FactoryBot.create(:user, name: 'User One', bio: 'Bio One') }
    let!(:post1) { FactoryBot.create(:post, user: user, content: 'Content One') }
    let!(:post2) { FactoryBot.create(:post, user: user, content: 'Content Two') }
    let!(:post3) { FactoryBot.create(:post, user: user, content: 'Content Three') }

    it 'shows the right content' do
      visit user_path(user)

      expect(page).to have_css("img[src*='#{user.profile_picture_url}']")
      expect(page).to have_content(user.name)
      expect(page).to have_content("Posts: #{user.posts.count}")
      expect(page).to have_content(user.bio)

      within '#posts' do
        expect(page).to have_content('Content One')
        expect(page).to have_content('Content Two')
        expect(page).to have_content('Content Three')

        expect(page).not_to have_content(post1.content, count: 4)
      end
    end
  end

  click_link 'Content One'

  expect(current_path).to eq(post_path(post1))

  describe 'index page' do
    it 'show the right content' do
      visit users_path
      expect(page).to have_content('home page')
    end
  end

end