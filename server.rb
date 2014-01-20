require 'sinatra'
require 'sinatra/static_assets'
require 'sqlite3'

# config
register Sinatra::StaticAssets
set :bind, '0.0.0.0'
db = SQLite3::Database.new("db/data.db")


recent_index = db.execute("select max(watched_id) from recent")
recent_index = recent_index[0][0]
if recent_index == nil
  recent_index = 0
end

def get_link(link)
  link_to("a", link).split('"')[1]
end

# routes
get '/' do
  movies = db.execute("select * from movies order by added desc limit 12")
  recently_watched = db.execute("select * from (recent inner join movies on recent.filename=movies.filename) order by watched_id desc")
  random = db.execute("select * from movies order by random() limit 6")
  erb :index, :locals => {:movies => movies, :recent => recently_watched, :random => random}
end

get '/browse' do
  order = params["sort"]
  order = "random()" if order.nil?
  movies = db.execute("select * from movies order by #{order}")
  erb :detail_movie_list, :locals => {:movies => movies, :title => "Browse All", :subtitle => "#{movies.count} movies (so far)", :show_sort => true}
end


# add movie to recently watched, then watch it.
get '/watch/*' do
  title = params[:splat][0]
  movie = db.execute("select * from movies where filename = '#{title}' limit 1")
  movie = movie[0]
  recent_index += 1
  db.execute("insert into recent(filename, watched_id, time, ip) VALUES('#{movie[16]}', #{ recent_index }, #{ Time.now.to_i }, '#{request.ip}' )")
  redirect get_link("/library/#{movie[16]}")
end

post '/request' do
  db.execute("insert into requests(name, request, status) values('#{params[:name]}', '#{params[:request]}', 'New')")
  erb :request, :locals => {:name => params[:name]}
end
get '/requests' do
  requests = db.execute('select * from requests')
  erb :view_requests, :locals => {:requests => requests}
end

post '/search' do
  q = params['search']
  movies = db.execute("select * from movies where title like '%#{q}%' or overview like '%#{q}%' or filename like '%#{q}%'")
  erb :detail_movie_list, :locals => {:movies => movies, :title => "Search Results", :subtitle => "#{movies.count} results for #{q}"}
end

get '/view/:id' do
  movie = db.execute("select * from movies where id=#{params[:id]}").first
  genres = db.execute("select * from genre where movie_id=?", movie[2])
  erb :show_movie, :locals => {:movie => movie, :genres => genres}
end

get '/random' do
  movie = db.execute("select * from movies order by random() limit 1").first
  redirect get_link("/view/#{movie[2]}")
end

get '/genre' do
  genres = db.execute("select distinct genre,genre_id from genre order by genre")
  movie_hash = {}
  genres.each do |g|
    movie_hash[g[1]] = db.execute("select * from movies where id in (select movie_id from genre where genre_id=#{g[1]}) order by random() limit 6")
  end
  erb :genre, :locals => {:movie_array => movie_hash, :genres => genres}
end
get '/genre/:g1' do
  genre = db.execute("select genre from genre where genre_id=#{params[:g1]}").first.first
  movies = db.execute("select * from movies where id in (select movie_id from genre where genre_id=#{params[:g1]})")
  erb :movie_list, :locals => {:movies => movies, :title => genre}
end
