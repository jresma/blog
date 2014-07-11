class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.text :password
      t.string :name

      t.timestamps
    end
  end
end
