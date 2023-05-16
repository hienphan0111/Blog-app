require 'rails_helper'
require "capybara/rspec"

RSpec.describe PostsController, type: :request do

  describe "GET /index" do
    let(:user) { User.create!(name: "John Doe", posts_counter: 0) }
    let(:post) { Post.create!(author_id: user.id, title: "My first post", text: "Hello World!", comments_counter: 0, likes_counter: 0) }

    it "renders a successful response" do
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it "renders the index template" do
      get "/users/#{user.id}/posts"
      expect(response).to render_template("posts/index")
    end
  end

  describe "GET show" do
    let(:user) { User.create!(name: "John Doe", posts_counter: 0) }
    let(:post) { Post.create!(author_id: user.id, title: "My first post", text: "Hello World!", comments_counter: 0, likes_counter: 0) }

    it "returns a successful response" do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it "renders the show template" do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('posts/detail_post')
    end

    it "returns a response body includes correct placeholder text" do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include("Show specific post's detail")
    end
  end

end
