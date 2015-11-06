class CreateMovies < ActiveRecord::Migration
  def change
    create_table(:movies) do |t|
      t.string :backdrop_path
      t.integer :budget
      t.string :imdb_id
      t.string :original_title
      t.string :overview
      t.string :popularity
      t.string :poster_path
      t.string :release_date
      t.integer :revenue
      t.integer :runtime
      t.string :status
      t.string :tagline
      t.string :title
      t.float :vote_average
      t.integer :vote_count
      t.string :filename
      t.string :added

      t.timestamps
    end
  end
end
