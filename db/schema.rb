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

ActiveRecord::Schema.define(version: 20140822144952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_groups", force: true do |t|
    t.string   "name"
    t.integer  "age_start"
    t.integer  "age_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camp_to_age_groups", force: true do |t|
    t.integer  "camp_id"
    t.integer  "age_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "camp_to_age_groups", ["camp_id"], name: "index_camp_to_age_groups_on_camp_id", using: :btree

  create_table "camps", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "date_time_locations", force: true do |t|
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "camp_id"
    t.integer  "rink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "date_time_locations", ["camp_id"], name: "index_date_time_locations_on_camp_id", using: :btree

  create_table "invitations", force: true do |t|
    t.string   "code"
    t.string   "player_id"
    t.string   "coach_id"
    t.date     "expiration_date"
    t.date     "use_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rinks", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.integer  "camp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["camp_id"], name: "index_skills_on_camp_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
