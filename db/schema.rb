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

ActiveRecord::Schema.define(version: 20151109232356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "citext"
  enable_extension "postgis"

  create_table "meetups", force: :cascade do |t|
    t.string    "name"
    t.string    "urlname"
    t.string    "category"
    t.string    "who"
    t.integer   "meetup_id"
    t.string    "city"
    t.string    "country"
    t.string    "link"
    t.decimal   "rating"
    t.string    "photo"
    t.string    "organizer_name"
    t.integer   "members_count"
    t.geography "coords",         limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime  "created_at",                                                              null: false
    t.datetime  "updated_at",                                                              null: false
  end

  add_index "meetups", ["coords"], name: "index_meetups_on_coords", using: :gist

  create_table "stores", force: :cascade do |t|
    t.string    "name"
    t.text      "street_address"
    t.geography "lonlat",         limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime  "created_at",                                                              null: false
    t.datetime  "updated_at",                                                              null: false
  end

  add_index "stores", ["lonlat"], name: "index_stores_on_lonlat", using: :gist

end
