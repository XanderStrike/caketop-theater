
class SettingsController < ApplicationController
	before_filter :authenticate

	def index
    @name = Setting.get(:name)
    @about = Setting.get(:about)
    @banner = Setting.get(:banner)
    @footer = Setting.get(:footer)
    @admin = Setting.get(:admin)
    @admin_pass = Setting.get('admin-pass')
    @url = Setting.get(:url)
    @pages = Page.all

    Setting.update(params) unless params[:setting].blank?

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
