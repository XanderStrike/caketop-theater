# frozen_string_literal: true
class CreateShows < ActiveRecord::Migration
  def change
    create_table(:shows) do |t|
      t.string :backdrop_path
      t.string :original_name
      t.string :first_air_date
      t.string :poster_path
      t.string :popularity
      t.string :name
      t.string :vote_average
      t.string :vote_count
      t.string :overview
      t.string :folder

      t.timestamps
    end
  end
end
