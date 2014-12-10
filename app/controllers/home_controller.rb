class HomeController < ApplicationController
  before_filter :authenticate, only: :settings

  NilMovie = Struct.new(:title)
  NilGenre = Struct.new(:name)

  def index
    @comments = Comment.where(movie_id: 0).order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.js { render 'comments/index' }
    end
  end

  def charts
    @top_movies = View.group(:movie_id).count.sort {|a,b| b[1] <=> a[1]}[0..19].map { |id, val|
      movie = Movie.find_by_id(id) || NilMovie.new("Unknown")
      [movie.title, val]
    }

    @views_by_day = View.where('created_at > ?', 1.week.ago).group_by { |u|
      u.created_at.localtime.beginning_of_day
    }.reduce({}) { |h, (k,v)|
      h[k] = v.size; h
    }

    @views_by_hour = View.where('').group_by(&:hour).map { |k, views| [k.to_i, views.count]}.sort
    @views_by_day_of_week = View.where('').group_by(&:day_of_week).sort.map { |k, views| [Date::DAYNAMES[k.to_i], views.count]}

    @genre_views = View.joins("JOIN genres ON genres.movie_id = views.movie_id").select("*").group("genres.name").count.sort { |a,b| b[1] <=> a[1] }

    @movies_per_genre = Genre.where('').group_by(&:name).map { |n, gs| [n, gs.count] }.sort {|a,b| b[1] <=> a[1]}
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
