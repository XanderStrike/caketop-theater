class FixGenres < ActiveRecord::Migration
  def up
    puts 'Saving current broken genres'
    tmp_genres = Genre.all.map do |g|
      "INSERT INTO genres (genre_id, movie_id, name) VALUES (#{g.id}, #{g.movie_id}, '#{g.name}')"
    end

    drop_table :genres

    create_table :genres do |t|
      t.integer :genre_id
      t.integer :movie_id
      t.string :name
    end

    puts 'Adding fixed genres'
    tmp_genres.each { |query| execute query }
  end

  def down
    puts "Could restore old genres, but we won't :P"
    puts "We'll put the table back how it was though"

    drop_table :genres
    create_table :genres, id: false do |t|
      t.string :id
      t.string :movie_id
      t.string :name

      t.timestamps
    end
  end
end
