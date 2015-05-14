class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id]).content
  end

  def new
    @page = Page.new
    render :edit
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    Page.new(params[:page]).save
    redirect_to settings_path
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    redirect_to settings_path
  end

  def destroy
    Page.find(params[:id]).destroy
    redirect_to settings_path
  end
end
