class ShowsController < ApplicationController
  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.order('name asc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shows }
    end
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @show = Show.find(params[:id])

    @seasons = {}
    @files = `ls "public/tv/#{ @show.folder }"`.split("\n")
    @files.each do |f|
      @seasons[f] = `find "public/tv/#{ @show.folder }/#{ f }" -type f`.split("\n").map {|ep| ep.gsub("public", "")}
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @show }
    end
  end

  def search
    @results = Movie.search(params[:q], fields: ["name^10", "original_name^10", "overview"])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end
end
