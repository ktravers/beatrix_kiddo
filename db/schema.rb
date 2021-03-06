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

ActiveRecord::Schema.define(version: 20161023022544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"

  create_table "events", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "slug",          null: false
    t.string   "venue_name"
    t.string   "venue_address"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plus_ones", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "guest_id"
    t.integer  "rsvp_id",     null: false
    t.datetime "accepted_at"
    t.datetime "declined_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "event_id",    null: false
    t.datetime "sent_at"
    t.datetime "accepted_at"
    t.datetime "declined_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", default: "", null: false
    t.string   "last_name",  default: "", null: false
    t.string   "email",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
