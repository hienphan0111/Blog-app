require 'rails_helper'

RSpec.describe UsersController, type: :request do

  describe "GET /index" do
    let(:valid_attributes) {{ name: 'Alice', photo: 'http://localhost:3000/anything.jpg', bio: 'Hello', posts_counter: 0}}

    it "render a successful response" do
      user = User.create! valid_attributes
      get '/users'
      expect(response).to be_successful
    end

    it "renders the show template" do
      get "/users"
      expect(response).to render_template('users/index')
    end
  end

  describe "GET /show/:id" do
    let(:user) { User.create!(name: "John Doe", photo: "http://localhost:3000/anything.jpg", bio: "User info", posts_counter: 0) }

    it "renders a successful response" do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it "renders the show template" do
      get "/users/#{user.id}"
      expect(response).to render_template('users/profile')
    end

    it "includes user bio in the response" do
      get "/users/#{user.id}"
      expect(response.body).to include(user.bio)
    end

  end

end
