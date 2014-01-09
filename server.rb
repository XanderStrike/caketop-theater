require 'sinatra'
require 'sinatra/static_assets'
require 'sqlite3'

# config
register Sinatra::StaticAssets
set :bind, '0.0.0.0'
db = SQLite3::Database.new("data.db")


recent_index = db.execute("select max(watched_id) from recent")
recent_index = recent_index[0][0]
if recent_index == nil
  recent_index = 0
end

# routes
get '/' do
  puts params

  order = params["sort"]
  order = "random()" if order.nil?

  recently_watched = db.execute("select * from movies where filename in (select filename from recent)")

  library = db.execute("select * from movies order by #{order}")
  puts library[0]
  erb :index, :locals => {:library => library, :recent => recently_watched}
end

# add movie to recently watched, then watch it.
get '/watch/*' do
  title = params[:splat][0]
  movie = db.execute("select * from movies where filename = '#{title}' limit 1")
  movie = movie[0]
  recent_index += 1
  db.execute("insert into recent(filename, watched_id) VALUES('#{movie[16]}', #{ recent_index } )")
  redirect ("/library/#{movie[16]}")
end

