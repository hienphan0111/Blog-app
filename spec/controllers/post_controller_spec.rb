require 'rails_helper'
require "capybara/rspec"

RSpec.describe PostsController, type: :controller do

  describe "GET /index" do
    it "renders the index template" do
      user = User.create(name: "John Doe", posts_counter: 0)
      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    let(:user) { User.create!(name: "John Doe", posts_counter: 0) }
    let(:post) { Post.create!(author_id: user.id, title: "My first post", text: "Hello World!", comments_counter: 0, likes_counter: 0) }

    it "returns a successful response" do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to be_successful
    end

    it "renders the show template" do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to render_template('posts/detail_post')
    end

    render_views
    it "returns a response body includes correct placeholder text" do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to render_template('posts/detail_post')
      expect(response.body).to include("Show specific post's detail")
    end
  end

end
