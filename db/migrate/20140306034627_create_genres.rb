class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres, id: false do |t|
      t.string :id
      t.string :movie_id
      t.string :name

      t.timestamps
    end
  end
end
