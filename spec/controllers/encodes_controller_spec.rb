require 'rails_helper'

RSpec.describe EncodesController, type: :controller do
  before(:each) do
    create_settings
  end

  describe "POST find_movie" do
		# this has js shit ugh
	end

	describe "GET retag" do
		it "creates a new movie and assigns the encode to it" do
			movie = create(:movie)
			encode = movie.encodes.first

			movie_count = Movie.count

			get :retag, id: encode.id, movie_id: 329
			encode.reload

			expect(Movie.count).to eq(movie_count + 1)
			expect(encode.movie).to_not eq(movie)
		end

		it "destroys the movie if there are no more encodes attached" do
			movie = create(:movie)
			movie.encodes.first.destroy
			encode = movie.encodes.first

			old_movie_id = movie.id

			movie_count = Movie.count

			get :retag, id: encode.id, movie_id: 329
			encode.reload

			expect(Movie.where(id: old_movie_id)).to be_empty
			expect(Movie.count).to eq(movie_count) # no change
		end

		it "adds the encode to a movie if one exists" do
			movie = create(:movie)
			new_movie = create(:movie, id: 329)
			encode = movie.encodes.first

			get :retag, id: encode.id, movie_id: new_movie.id
			encode.reload

			expect(encode.movie).to eq(new_movie)
		end
	end
end
