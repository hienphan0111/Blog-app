class AddUsersRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :users, null: false, foreign_key: true
    add_column :posts, :author_id, :string
  end
end
