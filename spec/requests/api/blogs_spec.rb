require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'api/blogs', type: :request do
  path '/users/{id}/posts' do
    let(:user) { User.create(name: 'John Doe') }

    get 'Retrieves all posts' do
      tags 'Blogs', 'Another Tag'
      produces 'application/json', 'application/xml'
      parameter :id, in: :path, schema: { type: :integer }
      response '200', 'posts found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              text: { type: :string }
            },
            required: [ 'id', 'title', 'text' ]
          }

        let(:id) { user.id }

        before do
          FactoryBot.create_list(:post, 5, user: user)
        end

        run_test!
      end

      response '404', 'user not found' do
        let(:id) { User.maximum(:id).to_i + 1 }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:id) { user.id }
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end
