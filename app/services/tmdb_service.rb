class TmdbService
  class TmdbError < StandardError
  end

  class << self
    def find_title_by_filename(filename)
      filename = filename.split('/').last.split(/[\s\.]/)
      filename.size.times do |x|
        next if x == 0
        results = search_movie_title(filename[0...(filename.length - x)].join(' '))
        return results[0] if results.size > 0
      end
      false
    end

    def search_movie_title(title)
      handle_status_codes do
        Tmdb::Movie.find(title)
      end
    end

    def get_movie_info(id)
      handle_status_codes do
        Tmdb::Movie.detail(id)
      end
    end

    def search_tv_title(title)
      handle_status_codes do
        Tmdb::TV.find(title)
      end
    end

    def get_tv_info(id)
      handle_status_codes do
        Tmdb::TV.detail(id)
      end
    end

    private

    def handle_status_codes(&block)
      response = yield(block)
      if response.is_a?(Hash) && response['status_code'].present?
        raise TmdbError, response['message']
      else
        response
      end
    end
  end
end
