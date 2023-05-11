class AddForeignKeyToLikes < ActiveRecord::Migration[7.0]
  def change
    change_table :likes do |t|
      t.bigint :user_id
      t.bigint :post_id
    end
    add_foreign_key :likes, :users, index: true
    add_foreign_key :likes, :posts, index: true
  end
end
