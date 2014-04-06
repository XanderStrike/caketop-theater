class MusicController < ApplicationController
  def index
    @artists = Artist.all
  end
  def show
    @album = Album.find(params[:id])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

end
