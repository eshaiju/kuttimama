class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :title
      t.string :status

      t.timestamps
    end
  end
end
