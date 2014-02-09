require 'net/http'
require 'sqlite3'
require 'themoviedb'

# config
Tmdb::Api.key("a230f1c8a13699563ac819f74fb16230")
directory = File.expand_path(File.dirname(__FILE__), "/media/nasdrive/tv/") 

# I'm keeping these separate because I might want to use a
#   different API or use multiple or something
def search_tv_title(title)
  Tmdb::TV.find(title)
end
def get_tv_info(id)
  Tmdb::TV.detail(id)
end

# iterates through a list of files finding which ones aren't in the
#   database and adding them
def populate_db(files)
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

# get list of files, run queries
files = `ls #{directory}`.split("\n").map {|f| f.gsub("#{directory}/", "")}
populate_db(files)
remove_missing(files)
puts "Scan complete. Check the web interface to ensure correctness of titles."
