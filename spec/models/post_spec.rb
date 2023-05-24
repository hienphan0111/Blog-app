require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'User1') }
  
  subject do
    described_class.new(
      title: 'First post',
      text: 'This is the first post',
      author: user,
      comments_counter: 1,
      likes_counter: 0
    )
  end
  
  let(:comment1) { Comment.create(text: "Comment 1") }
  let(:comment2) { Comment.create(text: "Comment 2") }
  let(:comment3) { Comment.create(text: "Comment 3") }
  let(:comment4) { Comment.create(text: "Comment 4") }
  let(:comment5) { Comment.create(text: "Comment 5") }

  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end
  

  describe '#five_recent_comments' do
    it 'returns the five most recent comments, ordered by created_at' do
      subject.comments << comment1 << comment2 << comment3 << comment4 << comment5
      expect(subject.five_recent_comments.to_a).to eq([comment1, comment2, comment3, comment4, comment5])
    end
  end
end
