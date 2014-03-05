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

      # download backdrop and poster
    end
  end

  desc "Scans for changes in the TV library folder."
  task :tv => :environment do
    p 'lol wow tv scan'
  end
end
