require 'sinatra'
require 'sqlite3'

# config
set :bind, '0.0.0.0'
db = SQLite3::Database.new("data.db")

# routes
get '/' do
  library = db.execute("select * from movies order by title")
  erb :index, :locals => {:library => library}
end

