require 'sinatra'
require 'sinatra/static_assets'
require 'sqlite3'
require 'active_record'

require './lib/models'

# db stuff
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'db/data.db')
