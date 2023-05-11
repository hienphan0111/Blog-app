require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'User1', photo: 'http://', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', posts_counter: 1)}

  let(:post1) { Post.create(title: "First post", text: "This is the first post") }
    let(:post2) { Post.create(title: "Second post", text: "This is the second post") }
    let(:post3) { Post.create(title: "Third post", text: "This is the third post") }

  # before { subject.save, post1.save, post2.save, post3.save }

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'Name is expected present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Posts counter is expected an number' do
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'Posts counter is expected an integer' do
    subject.posts_counter = 1.2
    expect(subject).to_not be_valid
  end

  it 'Posts counter is expected greater than or equal 0' do
    subject.posts_counter = -2
    expect(subject).to_not be_valid
  end

  it "returns the three last posts" do
    subject.posts << post1 << post2 << post3
    
    puts post1.author
    expect(subject.three_last_posts.length).to eq(3)
  end
end
