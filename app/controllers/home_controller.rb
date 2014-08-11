class HomeController < ApplicationController
  before_filter :authenticate, only: :settings


  def index
    redirect_to(action: 'settings', first_time: true) if Setting.where(name: 'name').first.nil?
  end

  def about
  end

  def settings
    @name = Setting.where(name: 'name').first || Setting.create(name: 'name', content: 'Caketop Theater')
    @about = Setting.where(name: 'about').first || Setting.create(name: 'about', content: "<h1>About Caketop</h1>\n\nCaketop Theater will make all your dreams come true!")
    @banner = Setting.where(name: 'banner').first || Setting.create(name: 'banner', content: '', boolean: false)

    @admin = Setting.where(name: 'admin').first || Setting.create(name: 'admin', content: '', boolean: false)
    @admin_pass = Setting.where(name: 'admin-pass').first || Setting.create(name: 'admin-pass', content: '')

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
    when 'admin'
      @admin.content = params[:admin_username]
      @admin.boolean = (params[:protect] == 'true')
      @admin_pass.content = Digest::SHA256.hexdigest(params[:admin_pass])
      @admin.save!
      @admin_pass.save!
    end

    @greeting = params[:first_time] ? "Welcome to Caketop" : "Settings"

    respond_to do |format|
      format.html
      format.js
    end
  end

  protected
  def authenticate
    setting = Setting.where(name: 'admin').first
    if (!(setting.nil?) && setting.boolean)
      authenticate_or_request_with_http_basic do |username, password|
        username == setting.content && Digest::SHA256.hexdigest(password) == Setting.where(name: 'admin-pass').first.content
      end
    else
      return true
    end
  end
end
