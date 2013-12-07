require 'sinatra'
require 'sqlite3'

# config
set :bind, '0.0.0.0'
db = SQLite3::Database.new("data.db")

# routes
get '/' do
  library = db.execute("select title, poster_path, filename from movies order by title")
  html = ""
  library.each do |movie|
    html += "<div>"
    html += "<img src=http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w185/" + movie[1]
    html += "<h1>" + movie[0] + "</h1>"
    html += "</div><br>\n"
  end
  return html
end
