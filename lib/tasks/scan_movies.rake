def search_title(title)
  Tmdb::Movie.find(title)
end
def get_info(id)
  Tmdb::Movie.detail(id)
end

def clean_title(title)
  title = title.split("/").last.split(/[\s\.]/)
  title.size.times do |x|
    next if x == 0
    results = search_title(title[0...(title.length - x)].join(" "))
    return results[0] if results.size > 0
  end
  return false
end

namespace :scan do
  desc "Scans for changes in the movie library folder."
  task :movies => :environment do
    puts "Movie scan starting..."

    formats = ['mp4', 'avi', 'xvid', 'divx', 'mts', 'mpeg', 'mkv', 'wmv', 'ogv', 'webm', 'mov', 'mpg', 'mpe', 'm4v', 'h264', 'avchd']



    # get file list
    movie_dirs = Settings.where(name: 'Movie-dir')
    files = movie_dirs.map { |movie_dir|
      `find #{movie_dirs["content"]} -type f`.split("\n").map {|f|
        f if formats.ay? { |w| f =~ /#{w}/ }
      }.compact
    }

    # populate db
    files.each do |file|

      # skip if we're already in the db
      next unless Encode.where(filename: file).empty?

      # find title, skip if we can't
      movie = clean_title(file)
      if movie == false
        puts "Error: Title for '#{file}' not found."
        next
      end

      # get extended info
      info = get_info(movie.id)

      # download backdrop and poster
      `wget https://d3gtl9l2a4fn1j.cloudfront.net/t/p/w500/#{ info.poster_path } -O ./public/posters/#{info.id}.jpg -b -q`
      `wget http://image.tmdb.org/t/p/w1000/#{ info.backdrop_path } -O ./public/backdrops/#{info.id}.jpg -b -q`

      # insert into db
      puts "Adding #{ file }\n    as #{ movie.title }"
      movie = Movie.find_by_id(info.id) || Movie.create(id: info.id)
      movie.backdrop_path = info.backdrop_path
      movie.backdrop_path = info.backdrop_path
      movie.budget = info.budget
      movie.id = info.id
      movie.imdb_id = info.imdb_id
      movie.original_title = info.original_title
      movie.overview = info.overview
      movie.popularity = info.popularity
      movie.poster_path = info.poster_path
      movie.release_date = info.release_date
      movie.revenue = info.revenue
      movie.runtime = info.runtime
      movie.status = info.status
      movie.tagline = info.tagline
      movie.title = info.title
      movie.vote_average = info.vote_average
      movie.vote_count = info.vote_count
      movie.added = Time.now.to_s
      movie.save

      # populate genres table (unless it already is)
      unless Genre.where(movie_id: info.id).count > 0
        info.genres.each do |g|
          Genre.create(id: g['id'], name: g['name'], movie_id: info.id)
        end
      end

      # get encode info
      mediainfo = Mediainfo.new "public/movies/#{file}"
      Encode.create(
              movie_id: info.id,
              filename: file,
              a_bitrate: mediainfo.audio[0].bit_rate,
              a_format: mediainfo.audio[0].format_info,
              a_stream_size: mediainfo.audio[0].stream_size,
              aspect_ratio: mediainfo.video[0].display_aspect_ratio,
              container: mediainfo.general.format,
              duration: mediainfo.general.duration_before_type_cast,
              framerate: mediainfo.video[0].frame_rate,
              resolution: mediainfo.video[0].width,
              rip_date: mediainfo.encoded_date,
              size: mediainfo.size,
              v_bitrate: mediainfo.video[0].bit_rate,
              v_codec: mediainfo.video[0].codec_id,
              v_format: mediainfo.video[0].format,
              v_profile: mediainfo.video[0].format_profile,
              v_stream_size: mediainfo.video[0].stream_size)
    end

    # remove missing
    missing = Encode.all.map(&:filename) - files
    Encode.where(filename: missing).map(&:destroy)
    Movie.all.each do |m|
      m.destroy if m.encodes.count < 1
    end
    unless missing.empty?
      p "Removed missing files:"
      p missing
    end

    puts "Movie scan complete."
 end
end
