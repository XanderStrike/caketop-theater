# frozen_string_literal: true
class Setting < ActiveRecord::Base
  DEFAULTS =
    {
      name:           { name: 'name', content: 'Caketop Theater', boolean: true },
      about:          { name: 'about', content: "<h1>About Caketop</h1>\n\nCaketop Theater will make all your dreams come true!", boolean: true },
      banner:         { name: 'banner', content: '<div class="alert alert-success">Hey, make sure to visit <a href="/settings">the settings page</a>!</div>', boolean: true },
      footer:         { name: 'footer', content: 'Maybe she\'s born with it, maybe it\'s caketop.', boolean: true },
      admin:          { name: 'admin', content: '', boolean: false },
      'admin-pass' => { name: 'admin-pass', content: '' },
      url:            { name: 'url', content: '' },
      movie_dir:      { name: 'movie_dir', content: '', boolean: true },
      tv_dir:         { name: 'tv_dir', content: '', boolean: true },
      music_dir:      { name: 'music_dir', content: '', boolean: true }
    }

  def self.render(name)
    if get(name).boolean
      get(name).content.html_safe
    else
      ''
    end
  end

  def self.get(name)
    Setting.find_by_name(name) || Setting.create(Setting::DEFAULTS[name])
  end

  def self.update(params)
    s = Setting.get(params[:setting])
    s.update_attribute(:content, params[:content])
    s.update_attribute(:boolean, (params[:boolean] == 'true'))
    Setting.get('admin-pass').update_attributes(content: Digest::SHA256.hexdigest(params[:admin_pass])) if params[:setting] == 'admin'
  end
end
