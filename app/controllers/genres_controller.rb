class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @movies = Movie.where(id: Genre.where(id: params[:id]).map(&:movie_id))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end
end
