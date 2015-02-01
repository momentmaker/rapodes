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

ActiveRecord::Schema.define(version: 20150201210903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.integer  "external_id"
    t.string   "name"
    t.string   "song_artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ode_artists", force: true do |t|
    t.string   "ode_id"
    t.string   "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "odes", force: true do |t|
    t.integer  "external_id"
    t.string   "title"
    t.string   "lyrics"
    t.string   "song_artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
