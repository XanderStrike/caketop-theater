class HomeController < ApplicationController
  def index
  end

  def about
  end

  def settings
    @name = Setting.where(name: 'name').first || Setting.create(name: 'name', content: 'Caketop Theater')
    @about = Setting.where(name: 'about').first || Setting.create(name: 'about', content: "<h1>About Caketop</h1>\n\nCaketop Theater will make all your dreams come true!")
    @banner = Setting.where(name: 'banner').first || Setting.create(name: 'banner', content: '', boolean: true)

    case params[:setting]
    when 'name'
      @name.content = params[:name_text]
      @name.save!
    when 'about'
      @about.content = params[:about_text]
      @about.save!
    when 'banner'
      @banner.content = params[:banner_text]
      @banner.boolean = (params[:banner_display] == 'true')
      @banner.save!
    end

    respond_to do |format|
      format.html
      format.js
  	end
  end
end
