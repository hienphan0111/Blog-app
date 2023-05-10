class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id', counter_cache: :posts_counter
  has_many :comments, :likes
end
