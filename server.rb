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

# routes
get '/' do
  order = params["sort"]
  order = "random()" if order.nil?

  recently_watched = db.execute("select * from (recent inner join movies on recent.filename=movies.filename) order by watched_id desc")

  library = db.execute("select * from movies order by #{order}")
  erb :index, :locals => {:library => library, :recent => recently_watched}
end

get '/new' do
  movies = db.execute("select * from movies order by added desc limit 12")
  recently_watched = db.execute("select * from (recent inner join movies on recent.filename=movies.filename) order by watched_id desc")
  erb :new, :locals => {:movies => movies, :recent => recently_watched}
end

# add movie to recently watched, then watch it.
get '/watch/*' do
  title = params[:splat][0]
  movie = db.execute("select * from movies where filename = '#{title}' limit 1")
  movie = movie[0]
  recent_index += 1
  db.execute("insert into recent(filename, watched_id, time, ip) VALUES('#{movie[16]}', #{ recent_index }, #{ Time.now.to_i }, '#{request.ip}' )")
  redirect link_to("asdf", "/library/#{movie[16]}").split('"')[1] 
end

post '/request' do
  db.execute("insert into requests(name, request, status) values('#{params[:name]}', '#{params[:request]}', 'New')")
  erb :request, :locals => {:name => params[:name]}
end
get '/requests' do
  requests = db.execute('select * from requests')
  erb :view_requests, :locals => {:requests => requests}
end
