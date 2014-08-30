class HomeController < ApplicationController
  before_filter :authenticate, only: :settings


  def index
  end

  def about
  end

  def settings
    @name = Setting.get(:name) || Setting.create(name: 'name', content: 'Caketop Theater', boolean: true)
    @about = Setting.get(:about) || Setting.create(name: 'about', content: "<h1>About Caketop</h1>\n\nCaketop Theater will make all your dreams come true!", boolean: true)
    @banner = Setting.get(:banner) || Setting.create(name: 'banner', content: '', boolean: false)
    @footer = Setting.get(:footer) || Setting.create(name: 'footer', content: 'Maybe she\'s born with it, maybe it\'s caketop.', boolean: true)

    @admin = Setting.get(:admin) || Setting.create(name: 'admin', content: '', boolean: false)
    @admin_pass = Setting.get('admin-pass') || Setting.create(name: 'admin-pass', content: '')

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
    when 'footer'
      @footer.content = params[:footer_text]
      @footer.boolean = (params[:footer_display] == 'true')
      @footer.save
    end

    @pages = Page.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  protected
  def authenticate
    setting = Setting.get(:admin)
    if (!(setting.nil?) && setting.boolean)
      authenticate_or_request_with_http_basic do |username, password|
        username == setting.content && Digest::SHA256.hexdigest(password) == Setting.where(name: 'admin-pass').first.content
      end
    else
      return true
    end
  end
end
