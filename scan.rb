require 'net/http'
require 'sqlite3'
require 'themoviedb'

# config
Tmdb::Api.key("a230f1c8a13699563ac819f74fb16230")
movie_directory = File.expand_path(File.dirname(__FILE__), "public/movies") 
tv_directory = File.expand_path(File.dirname(__FILE__), "public/tv") 

# I'm keeping these separate because I might want to use a
#   different API or use multiple or something
def search_title(title)
  Tmdb::Movie.find(title)
end
def get_info(id)
  Tmdb::Movie.detail(id)
end
def search_tv_title(title)
  Tmdb::TV.find(title)
end
def get_tv_info(id)
  Tmdb::TV.detail(id)
end

# iteratively hit api for smaller and smaller pieces of filename
#   expects filenames like "The.Movie.2012.720p.AbcHD.mp4"
def clean_title(title)
  title = title.split("/").last.split(/[\s\.]/)
  title.size.times do |x|
    next if x == 0
    results = search_title(title[0...(title.length - x)].join(" "))
    return results[0] if results.size > 0
  end
  return false
end

# iterates through a list of files finding which ones aren't in the
#   database and adding them
def populate_db(files)
  db = SQLite3::Database.new("db/data.db")

  files.each do |file|
    if db.get_first_value("select count(1) from movies where filename = ?", file) == 0
      movie = clean_title(file)

      if movie == false
        puts "Error: Title for '#{file}' not found, skipping."
        next
      end

      # main movies table population
      puts "Adding #{ file }\n  as #{ movie.title }."
      info = get_info(movie.id)
      db.execute("insert into movies values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
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
                    file,
                    Time.now.to_s)

      # genre table population
      info.genres.each do |g|
        db.execute("insert into genres values (?, ?, ?)", info.id, g['name'], g['id'])
      end

      # download poster
      `wget https://d3gtl9l2a4fn1j.cloudfront.net/t/p/w500/#{ info.poster_path } -O ./public/img/posters/#{info.id}.jpg -b -q`

      # download backdrop
      `wget http://image.tmdb.org/t/p/w1000/#{ info.backdrop_path } -O ./public/img/backdrops/#{info.id}.jpg -b -q`
    end
  end
  
  puts "Done."
end

def populate_tv_db(files)
  puts "Scanning for new files:"
  db = SQLite3::Database.new("db/data.db")

  files.each do |file|
    if db.get_first_value("select count(1) from shows where filename = ?", file) == 0

      show = search_tv_title(file).first

      if show.nil?
        puts "Error: Title for '#{file}' not found, skipping."
        next
      end

      # main movies table population
      puts "Adding #{ file }\n  as #{ show.name }."
      info = get_tv_info(show.id)
      db.execute("insert into shows values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
                    info.backdrop_path,
                    info.id,
                    info.original_name,
                    info.first_air_date,
                    info.poster_path,
                    info.popularity,
                    info.name,
                    info.vote_average,
                    info.vote_count,
                    info.overview,
                    file,
                    Time.now.to_s)

      # genre table population
      info.genres.each do |g|
        db.execute("insert into genres values (?, ?, ?)", info.id, g['name'], g['id'])
      end

      # download poster
      `wget https://d3gtl9l2a4fn1j.cloudfront.net/t/p/w500/#{ info.poster_path } -O ./public/img/posters/#{info.id}.jpg -b -q`

      # download backdrop
      `wget http://image.tmdb.org/t/p/w1000/#{ info.backdrop_path } -O ./public/img/backdrops/#{info.id}.jpg -b -q`
    end
  end
  puts "Done."
end

def remove_missing(files)
  puts 'Removing missing files:'
  db = SQLite3::Database.new('db/data.db')
  dbfiles = db.execute("select filename from movies")
  missing = dbfiles.map(&:first) - files
  missing.each do |f|
    puts "#{f}"
    id = db.execute("select id from movies where filename = ?", f).first
    db.execute("delete from genres where movie_id = ?", id)
    db.execute("delete from movies where filename = ?", f)
  end
  puts 'Done.'
end
def remove_missing_tv(files)
  puts 'Removing missing files:'
  db = SQLite3::Database.new('db/data.db')
  dbfiles = db.execute("select filename from shows")
  missing = dbfiles.map(&:first) - files
  missing.each do |f|
    puts "#{f}"
    id = db.execute("select id from shows where filename = ?", f).first
    db.execute("delete from genres where movie_id = ?", id)
    db.execute("delete from shows where filename = ?", f)
  end
  puts 'Done.'
end

# get list of movie files, run queries
puts "Scanning for new movies:"
files = `find #{movie_directory}/ -type f`.split("\n").map {|f| f.gsub("#{movie_directory}/", "")}
populate_db(files)
remove_missing(files)
puts "Movie scan complete."

# get list of files, run queries
puts "Scanning for new tv shows:"
files = `ls #{tv_directory}`.split("\n").map {|f| f.gsub("#{tv_directory}/", "")}
populate_tv_db(files)
remove_missing_tv(files)
puts "TV scan complete. Check the web interface to ensure correctness of titles."
