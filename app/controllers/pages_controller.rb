# frozen_string_literal: true
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
    Page.new(page_params).save
    redirect_to settings_path
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(page_params)
    redirect_to settings_path
  end

  def destroy
    Page.find(params[:id]).destroy
    redirect_to settings_path
  end

  private

  def page_params
    params.require(:page).permit(:text, :name, :navbar, :footer)
  end
end
