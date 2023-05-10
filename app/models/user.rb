class User < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts, foreign_key: 'author_id'

  def three_last_posts
    posts.last(3)
  end
end
