class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.datetime :date
      t.string :author
      t.integer :likes

      t.timestamps
    end
  end
end
