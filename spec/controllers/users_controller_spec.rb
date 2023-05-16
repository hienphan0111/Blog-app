require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET /index" do
    let(:valid_attributes) {{ name: 'Alice', photo: 'http://', bio: 'Hello', posts_counter: 0}}
    it "render a successful response" do
      user = User.create! valid_attributes
      get :index
      expect(response).to be_successful
    end

    describe "GET #show" do
      let(:user) { User.create!(name: "John Doe", posts_counter: 0) }

      it "renders a successful response" do
        get :show, params: { id: user.id }
        expect(response).to be_successful
      end

      it "renders the show template" do
        get :show, params: { id: user.id }
        expect(response).to render_template('users/profile')
      end
  
      render_views
      it "returns a response body includes correct placeholder text" do
        get :show, params: { id: user.id }
        expect(response.body).to include("Profile page")
      end
    end
  end

end
