# frozen_string_literal: true
class GenresController < ApplicationController
  def show
    @genre = Genre.where(id: params[:id]).first
    @movies = MovieSearch.new(genre: @genre.genre_id).results
  end
end
