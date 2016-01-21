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

ActiveRecord::Schema.define(version: 20160121025619) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "private",     default: false, null: false
    t.integer  "links_count", default: 0,     null: false
    t.integer  "users_count", default: 0,     null: false
    t.boolean  "predefined"
  end

  create_table "category_link_relationships", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "link_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "category_link_relationships", ["category_id"], name: "index_category_link_relationships_on_category_id"
  add_index "category_link_relationships", ["link_id"], name: "index_category_link_relationships_on_link_id"

  create_table "link_reviews", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_link_relationship_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "link_reviews", ["user_link_relationship_id"], name: "index_link_reviews_on_user_link_relationship_id"

  create_table "links", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "link_description"
    t.text     "link_picture"
    t.string   "link_title"
    t.integer  "website_id"
    t.integer  "users_count",      default: 0, null: false
    t.integer  "categories_count", default: 0, null: false
  end

  add_index "links", ["website_id"], name: "index_links_on_website_id"

  create_table "user_category_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_category_relationships", ["category_id"], name: "index_user_category_relationships_on_category_id"
  add_index "user_category_relationships", ["user_id"], name: "index_user_category_relationships_on_user_id"

  create_table "user_link_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "link_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "link_reviews_count", default: 0, null: false
  end

  add_index "user_link_relationships", ["link_id"], name: "index_user_link_relationships_on_link_id"
  add_index "user_link_relationships", ["user_id"], name: "index_user_link_relationships_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "links_count",            default: 0,  null: false
    t.integer  "categories_count",       default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "websites", force: :cascade do |t|
    t.string   "host"
    t.string   "scheme"
    t.string   "title"
    t.integer  "count",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "links_count", default: 0, null: false
  end

  add_index "websites", ["host"], name: "index_websites_on_host"

end
