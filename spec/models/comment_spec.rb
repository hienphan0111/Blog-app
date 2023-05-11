require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'This is a comment') }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

end
