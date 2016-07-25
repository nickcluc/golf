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

ActiveRecord::Schema.define(version: 20151211200848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.string   "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string  "name",           null: false
    t.string  "street_address", null: false
    t.string  "city",           null: false
    t.string  "state",          null: false
    t.string  "zip_code",       null: false
    t.integer "user_id",        null: false
    t.string  "phone"
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id",                   null: false
    t.integer "friend_id",                 null: false
    t.boolean "accepted",  default: false, null: false
    t.boolean "ignored",   default: false
  end

  create_table "player_rounds", force: :cascade do |t|
    t.integer "user_id",                    null: false
    t.integer "round_id",                   null: false
    t.integer "score"
    t.integer "hole_count"
    t.integer "tee_id"
    t.boolean "completed",  default: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "recipient_id", null: false
    t.text     "body",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["recipient_id"], name: "index_posts_on_recipient_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "course_id",  null: false
    t.date     "round_date", null: false
    t.time     "tee_time",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tees", force: :cascade do |t|
    t.string  "color",     null: false
    t.integer "slope",     null: false
    t.float   "rating",    null: false
    t.integer "yardage",   null: false
    t.integer "course_id", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "handicap"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cover_image"
    t.string   "profile_photo"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
