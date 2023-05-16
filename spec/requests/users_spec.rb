require 'rails_helper'

RSpec.describe UsersController, type: :request do

  describe "GET /index" do
    let(:valid_attributes) {{ name: 'Alice', photo: 'http://', bio: 'Hello', posts_counter: 0}}

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
    let(:user) { User.create!(name: "John Doe", posts_counter: 0) }

    it "renders a successful response" do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it "renders the show template" do
      get "/users/#{user.id}"
      expect(response).to render_template('users/profile')
    end

    it "returns a response body includes correct placeholder text" do
      get "/users/#{user.id}"
      expect(response.body).to include("Profile page")
    end
  end

end
