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

ActiveRecord::Schema.define(version: 20180507172332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "link"
    t.string "city"
    t.datetime "post_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_jobs_on_city"
    t.index ["link"], name: "index_jobs_on_link", unique: true
    t.index ["post_time"], name: "index_jobs_on_post_time"
    t.index ["title"], name: "index_jobs_on_title"
  end

  create_table "searches", force: :cascade do |t|
    t.string "search_terms"
    t.boolean "telecommute"
    t.boolean "full_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_time"], name: "index_searches_on_full_time"
    t.index ["search_terms"], name: "index_searches_on_search_terms"
    t.index ["telecommute"], name: "index_searches_on_telecommute"
  end

end
