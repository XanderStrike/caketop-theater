require 'sinatra'
require 'sqlite3'

# config
set :bind, '0.0.0.0'
db = SQLite3::Database.new("data.db")

# routes
get '/' do
  puts params

  order = params["sort"]
  order = "title" if order.nil?

  library = db.execute("select * from movies order by #{order}")
  erb :index, :locals => {:library => library}
end

