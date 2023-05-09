class AddForeignKeyToLikes < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :likes, :users, index: true
    add_foreign_key :likes, :posts, index: true
  end
end
