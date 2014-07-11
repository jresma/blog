class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :permalink
      t.text :content
      t.references :users, index: true

      t.timestamps
    end
  end
end
