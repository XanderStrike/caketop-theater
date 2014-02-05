require 'net/http'
require 'sqlite3'
require 'themoviedb'

# config
Tmdb::Api.key("a230f1c8a13699563ac819f74fb16230")
directory = File.expand_path(File.dirname(__FILE__), "public/library") 

# I'm keeping these separate because I might want to use a
#   different API or use multiple or something
def search_title(title)
  Tmdb::Movie.find(title)
end
def get_info(id)
  Tmdb::Movie.detail(id)
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
  puts "Scanning for new files:"
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

# get list of files, run queries
files = `find #{directory}/ -type f`.split("\n").map {|f| f.gsub("#{directory}/", "")}
populate_db(files)
remove_missing(files)
puts "Scan complete. Check the web interface to ensure correctness of titles."
