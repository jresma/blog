class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.string :original_filename
      t.string :filepath
      t.string :mimetype
      t.string :filename
      t.references :posts, index: true

      t.timestamps
    end
  end
end
