# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150307175148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "artist_id"
    t.string   "name"
    t.string   "art"
    t.string   "year"
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url"
    t.text     "image"
    t.text     "bio"
    t.text     "year"
    t.text     "home"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "name"
    t.string   "body"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
  end

  create_table "encodes", force: :cascade do |t|
    t.string   "container"
    t.string   "size"
    t.string   "duration"
    t.string   "rip_date"
    t.string   "v_format"
    t.string   "v_profile"
    t.string   "v_codec"
    t.string   "resolution"
    t.string   "aspect_ratio"
    t.string   "v_bitrate"
    t.string   "framerate"
    t.string   "v_stream_size"
    t.string   "a_format"
    t.string   "a_bitrate"
    t.string   "a_stream_size"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "filename"
  end

  create_table "genres", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "movie_id"
    t.string  "name"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "backdrop_path"
    t.integer  "budget"
    t.string   "imdb_id"
    t.string   "original_title"
    t.string   "overview"
    t.string   "popularity"
    t.string   "poster_path"
    t.string   "release_date"
    t.integer  "revenue"
    t.integer  "runtime"
    t.string   "status"
    t.string   "tagline"
    t.string   "title"
    t.float    "vote_average"
    t.integer  "vote_count"
    t.string   "added"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.text     "text"
    t.text     "content"
    t.string   "name"
    t.boolean  "navbar"
    t.boolean  "footer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["name"], name: "index_pages_on_name", unique: true, using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "name"
    t.string   "content"
    t.integer  "number"
    t.boolean  "boolean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", force: :cascade do |t|
    t.string   "backdrop_path"
    t.string   "original_name"
    t.string   "first_air_date"
    t.string   "poster_path"
    t.string   "popularity"
    t.string   "name"
    t.string   "vote_average"
    t.string   "vote_count"
    t.string   "overview"
    t.string   "folder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "title"
    t.string   "filename"
    t.integer  "track"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "views", force: :cascade do |t|
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
