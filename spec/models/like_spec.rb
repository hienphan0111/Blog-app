require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { build(:like) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end

