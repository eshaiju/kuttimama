class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.attachment :image
      t.references :movie, index: true
      t.references :category, index: true
      t.references :tag, index: true
      t.string :status

      t.timestamps
    end
  end
end
