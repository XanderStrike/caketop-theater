def search_tv_title(title)
  Tmdb::TV.find(title)
end
def get_tv_info(id)
  Tmdb::TV.detail(id)
end

namespace :scan do
  desc "Scans for changes in the TV library folder."
  task :tv => :environment do
    puts "Scanning for new tv shows:"

    files = `ls public/tv `.split("\n").map {|f| f.gsub("public/tv/", "")}

    files.each do |file|
      show = search_tv_title(file).first

      if show.nil?
        puts "Error: Title for '#{file}' not found, skipping."
        next
      end

      next if Show.where(id: show.id).count > 0

      # insert into db
      puts "Adding #{ file }\n    as #{ show.name }"
      info = get_tv_info(show.id)
      Show.create(backdrop_path: info.backdrop_path,
                  id: info.id,
                  original_name:  info.original_name,
                  first_air_date:  info.first_air_date,
                  poster_path:  info.poster_path,
                  popularity:  info.popularity,
                  name:  info.name,
                  vote_average:  info.vote_average,
                  vote_count:  info.vote_count,
                  overview:  info.overview,
                  folder:  file)

      # populate genres table (unless it already is)
      unless Genre.where(movie_id: show.id).count > 0
        info.genres.each do |g|
          Genre.create(id: g['id'], name: g['name'], movie_id: show.id)
        end
      end

      # download images
      `wget http://image.tmdb.org/t/p/w500/#{ info.poster_path } -O ./public/posters/tv_#{info.id}.jpg -b -q`
      `wget http://image.tmdb.org/t/p/w1000/#{ info.backdrop_path } -O ./public/backdrops/tv_#{info.id}.jpg -b -q`
    end

    puts "TV scan complete."
  end
end
