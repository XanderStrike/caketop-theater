class MusicController < ApplicationController
  def index
    @artists = Artist.where("name like ?", "%#{params[:artist]}%").order('name asc')
    @partial = 'music/artists'

    @url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"

    @page_size = 24
    @limited_artists = @artists.limit(@page_size).offset(@page_size * params[:page].to_i)

    respond_to do |format|
      format.html { render 'index.html' }
      format.js { render layout: false }
    end
  end

  def artist
    @artist = Artist.where(id: params[:id]).first
    @partial = 'music/artist_page'

    @url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"

    respond_to do |format|
      format.html { render 'index.html'}
      format.js { render 'index.js' }
    end
  end
end
