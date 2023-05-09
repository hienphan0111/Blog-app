class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, index: true
      t.text :text
      t.number :comments_counter

      t.timestamps
    end
  end
end
