require 'net/http'
require 'active_record'
require 'themoviedb'
require 'sqlite3'

# config
Tmdb::Api.key("a230f1c8a13699563ac819f74fb16230")

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'db/data.db')
db = SQLite3::Database.new("db/data.db")

class Movies < ActiveRecord::Base

  def related
    arr = []

    page = 1
    while arr.count < 6 && page < 10
      related_ids = Tmdb::Search.new("/movie/#{ self.id }/similar_movies?page=#{ page + 1 }").fetch_response['results'].map {|m| m['id']}
      arr += Movies.where(id: related_ids) #Movies.find_all_by_id(related_ids)
      page += 1
    end

    return arr
  end

end

class Similars < ActiveRecord::Base

end

db.execute("delete from similars")

Movies.all.each do |m|
  puts "#{m.title} is similar to:"
  m.related.each do |m_related|
    puts m_related.title
    Similars.new(movie: m.id, related_movie: m_related.id).save
  end 
end
