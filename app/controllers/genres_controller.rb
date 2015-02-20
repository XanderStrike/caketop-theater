class GenresController < ApplicationController
  def show
    @genre = Genre.where(id: params[:id]).first
    @movies = MovieSearch.new(genre: @genre.id).results

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end
end
