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

ActiveRecord::Schema.define(version: 20201110120550) do

  create_table "authors", force: :cascade do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "username"
    t.integer  "profile_image_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "facebooks_id"
    t.integer  "twitters_id"
    t.integer  "profiles_id"
    t.boolean  "can_post"
    t.string   "token"
  end

  add_index "authors", [nil], name: "unique_usernames", unique: true

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "post_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facebooks", force: :cascade do |t|
    t.string   "profile_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "author_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "comment_id"
    t.string   "article"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", [nil], name: "index_posts_on_comment"

  create_table "profiles", force: :cascade do |t|
    t.string   "profile_image"
    t.string   "bio"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "author_id"
  end

  create_table "twitters", force: :cascade do |t|
    t.string   "profile_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "author_id"
  end

end
