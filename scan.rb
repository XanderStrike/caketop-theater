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
        db.execute("insert into genre values (?, ?, ?)", info.id, g['name'], g['id'])
      end

    end
  end
  
  puts "Done."
end

def remove_missing(files)
  puts 'Removing missing files:'
  db = SQLite3::Database.new('db/data.db')
  dbfiles = db.execute("select filename from movies")
  missing = dbfiles.map(&:first) - files
  missing.each {|f| puts "#{f}"; db.execute("delete from movies where filename = ?", f)}
  puts 'Done.'
end

# get list of files, run queries
files = `find #{directory}/ -type f`.split("\n").map {|f| f.gsub("#{directory}/", "")}
populate_db(files)
remove_missing(files)
puts "Scan complete. Check the web interface to ensure correctness of titles."
