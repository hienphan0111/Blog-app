class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :posts_counter
  has_many :comments, class_name: 'Comment', dependent: :destroy
  has_many :likes, class_name: 'Like'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def five_recent_comments
    comments.last(5)
  end

  before_destroy :delete_comments

  private

  def delete_comments
    comments.delete_all
  end
end
