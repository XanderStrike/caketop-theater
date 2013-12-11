require 'sinatra'
require 'sinatra/static_assets'
require 'sqlite3'

# config
register Sinatra::StaticAssets
set :bind, '0.0.0.0'
db = SQLite3::Database.new("data.db")

# routes
get '/' do
  puts params

  order = params["sort"]
  order = "random()" if order.nil?

  library = db.execute("select * from movies order by #{order}")
  erb :index, :locals => {:library => library}
end

