require 'net/http'
require 'sqlite3'
require 'themoviedb'

# config
Tmdb::Api.key("a230f1c8a13699563ac819f74fb16230")
db = SQLite3::Database.new("data.db")

# methods
def clean_title(title)
  title = title.split(/[\s\.]/)
  title.size.times do |x|
    next if x == 0
    results = Tmdb::Movie.find(title[0...(title.length - x)].join(" "))
    return results[0] if results.size > 0
  end
  return false
end

def get_info(id)
  return Tmdb::Movie.detail(id)
end

# get list of files, run queries
files = `find /media/nasdrive/movies -maxdepth 1 -type f -printf '%f\n'`.split("\n")
files.each do |file|
  puts
  puts "Searching for " + file
  if db.get_first_value("select count(1) from movies where filename = ?", file) > 0
    puts "Already exists in DB, skipping..."
  else
    movie = clean_title(file)
    if movie == false
      puts "Title not found '#{file}', skipping..."
      next
    end
    puts movie.title
    info = get_info(movie.id)
    puts info.overview
    db.execute("insert into movies values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
                  info.backdrop_path,
                  info.budget,
                  info.id,
                  info.imdb_id,
                  info.original_title,
                  info.overview,
                  info.popularity,
                  info.poster_path,
                  info.release_date,
                  info.revenue,
                  info.runtime,
                  info.status,
                  info.tagline,
                  info.title,
                  info.vote_average,
                  info.vote_count,
                  file)
  end
end
