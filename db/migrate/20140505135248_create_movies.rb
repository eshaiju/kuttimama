class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :title
      t.string :year
      t.text :actors
      t.string :status

      t.timestamps
    end
  end
end
