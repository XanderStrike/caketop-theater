class TmdbService
  class << self
    def search_movie_title(title)
      Tmdb::Movie.find(title)
    end

    def get_movie_info(id)
      Tmdb::Movie.detail(id)
    end

    def search_tv_title(title)
      Tmdb::TV.find(title)
    end

    def get_tv_info(id)
      Tmdb::TV.detail(id)
    end
  end
end
