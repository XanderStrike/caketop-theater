class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :backdrop_path
      t.string :budget
      t.string :id
      t.string :imdb_id
      t.string :original_title
      t.string :overview
      t.string :popularity
      t.string :poster_path
      t.string :release_date
      t.string :revenue
      t.string :runtime
      t.string :status
      t.string :tagline
      t.string :title
      t.string :vote_average
      t.string :vote_count
      t.string :filename
      t.string :added

      t.timestamps
    end
  end
end
