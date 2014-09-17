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

ActiveRecord::Schema.define(version: 20140916223236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_groups", force: true do |t|
    t.string   "name"
    t.integer  "age_start"
    t.integer  "age_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "camp_to_age_groups", force: true do |t|
    t.integer  "camp_id"
    t.integer  "age_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "camp_to_age_groups", ["camp_id"], name: "index_camp_to_age_groups_on_camp_id", using: :btree

  create_table "camp_to_skills", force: true do |t|
    t.integer  "camp_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camps", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "publish_date"
    t.string   "age_group"
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

  create_table "player_camp_invitations", force: true do |t|
    t.integer  "player_id"
    t.integer  "camp_id"
    t.date     "invite_date"
    t.date     "uninvite_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_evaluation_to_skills", force: true do |t|
    t.integer  "player_evaluation_id"
    t.integer  "player_skill_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_evaluation_to_skills", ["player_evaluation_id"], name: "index_player_evaluation_to_skills_on_player_evaluation_id", using: :btree
  add_index "player_evaluation_to_skills", ["player_skill_id"], name: "index_player_evaluation_to_skills_on_player_skill_id", using: :btree

  create_table "player_evaluations", force: true do |t|
    t.integer  "player_id"
    t.string   "evaluation_type"
    t.string   "league"
    t.string   "team"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "shoots"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rinks", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tool_tip"
    t.string   "skill_type"
    t.integer  "order"
    t.boolean  "active"
  end

  create_table "user_invitations", force: true do |t|
    t.string   "invitation_code"
    t.integer  "player_id"
    t.integer  "coach_id"
    t.date     "expiration_date"
    t.date     "use_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_to_players", force: true do |t|
    t.integer  "user_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
