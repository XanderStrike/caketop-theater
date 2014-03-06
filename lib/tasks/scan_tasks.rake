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
    p 'Movie scan starting...'

    # get file list
    files = `find public/movies/ -type f`.split("\n").map {|f| f.gsub('public/movies/', '')}

    # populate db
    files.each do |file|

      # skip if we're already in the db
      next unless Movie.where(filename: file).empty?

      # find title, skip if we can't
      movie = clean_title(file)
      if movie == false
        puts "Error: Title for '#{file}' not found."
        next
      end

      # get extended info
      info = get_info(movie.id)

      # download backdrop and poster
      `wget https://d3gtl9l2a4fn1j.cloudfront.net/t/p/w500/#{ info.poster_path } -O ./app/assets/images/posters/#{info.id}.jpg -b -q`
      `wget http://image.tmdb.org/t/p/w1000/#{ info.backdrop_path } -O ./app/assets/images/backdrops/#{info.id}.jpg -b -q`

      # insert into db
      puts "Adding #{ file }\n    as #{ movie.title }"
      Movie.create(
              backdrop_path: info.backdrop_path,
              backdrop_path: info.backdrop_path,
              budget: info.budget,
              id: info.id,
              imdb_id: info.imdb_id,
              original_title: info.original_title,
              overview: info.overview,
              popularity: info.popularity,
              poster_path: info.poster_path,
              release_date: info.release_date,
              revenue: info.revenue,
              runtime: info.runtime,
              status: info.status,
              tagline: info.tagline,
              title: info.title,
              vote_average: info.vote_average,
              vote_count: info.vote_count,
              filename: file,
              added: Time.now.to_s)

      # populate genres table
      info.genres.each do |g|
        Genre.create(id: g['id'], name: g['name'], movie_id: info.id)
      end

      # get encode info
      mediainfo = Mediainfo.new "public/movies/#{file}"
      Encode.create(
              movie_id: info.id, 
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
  end

  desc "Scans for changes in the TV library folder."
  task :tv => :environment do
    p 'lol wow tv scan'
  end
end
