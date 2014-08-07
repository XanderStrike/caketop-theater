class PageController < ApplicationController
  def show
    @page = Page.find(params[:id]).content
  end
end
