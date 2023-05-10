class ChangeForeignKeyComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :users_id, :posts_id
      t.bigint :user_id
      t.index :user_id
      t.bigint :post_id
      t.index :post_id
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
