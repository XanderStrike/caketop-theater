class ShowsController < ApplicationController
  include ModelSearch
  # GET /shows
  # GET /shows.json

  SEARCHABLE_FIELDS = %w(name original_name folder overview)

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
      format.html
      format.json { render json: @show }
    end
  end

  def search
    @shows = model_search(Show, SEARCHABLE_FIELDS, params[:q])

    respond_to do |format|
      format.html
      format.json { render json: @shows }
    end
  end
end
