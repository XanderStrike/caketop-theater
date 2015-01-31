class GenresController < ApplicationController
  def show
    @genre = Genre.where(id: params[:id]).first
    @movies = Genre.where(id: params[:id]).map(&:movie)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end
end
