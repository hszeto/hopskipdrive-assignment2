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

ActiveRecord::Schema.define(version: 2019_04_11_091712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "repeating_rides", force: :cascade do |t|
    t.integer "frequency"
    t.string "location"
    t.string "time"
    t.text "days", default: "--- []\n"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repeating_rides_on_user_id"
  end

  create_table "rides", force: :cascade do |t|
    t.string "time"
    t.string "location"
    t.bigint "repeating_ride_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date"
    t.index ["repeating_ride_id"], name: "index_rides_on_repeating_ride_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "repeating_rides", "users"
  add_foreign_key "rides", "repeating_rides"
end
