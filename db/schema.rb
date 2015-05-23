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

ActiveRecord::Schema.define(version: 20150521162505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
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
    t.string   "role"
    t.text     "keen_scoped_key"
    t.integer  "retailer_id"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["retailer_id"], name: "index_admins_on_retailer_id", using: :btree

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "human_demographics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "human_demographics_categories", force: true do |t|
    t.integer  "human_demographic_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "human_demographics_categories", ["category_id"], name: "index_human_demographics_categories_on_category_id", using: :btree
  add_index "human_demographics_categories", ["human_demographic_id"], name: "index_human_demographics_categories_on_human_demographic_id", using: :btree

  create_table "product_images", force: true do |t|
    t.integer  "product_variation_id"
    t.text     "filepath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_images", ["product_variation_id"], name: "index_product_images_on_product_variation_id", using: :btree

  create_table "product_variations", force: true do |t|
    t.integer  "product_id"
    t.string   "origin_id"
    t.string   "name"
    t.text     "swatch_filepath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_variations", ["product_id"], name: "index_product_variations_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "homepage_product_link"
    t.float    "original_price"
    t.float    "sale_price"
    t.integer  "retailer_id"
    t.string   "origin_id"
    t.integer  "category_id"
    t.boolean  "active",                default: true
    t.integer  "upvotes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "viewed_count"
    t.float    "trendiness_score"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["retailer_id"], name: "index_products_on_retailer_id", using: :btree

  create_table "retailers", force: true do |t|
    t.string   "name"
    t.text     "homepage_link"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "retailers", ["city_id"], name: "index_retailers_on_city_id", using: :btree

  create_table "retailers_social_medias", force: true do |t|
    t.integer  "social_media_id"
    t.integer  "retailer_id"
    t.text     "social_media_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "retailers_social_medias", ["retailer_id"], name: "index_retailers_social_medias_on_retailer_id", using: :btree

  create_table "social_medias", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_picture"
    t.string   "name"
    t.string   "auth_token",             default: ""
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "activated",              default: false
  end

  add_index "users", ["activated"], name: "index_users_on_activated", using: :btree
  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "variation_sizes", force: true do |t|
    t.integer  "product_variation_id"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variation_stocks", force: true do |t|
    t.integer  "product_variation_id"
    t.integer  "min"
    t.integer  "max"
    t.boolean  "has_more"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variation_stocks", ["product_variation_id"], name: "index_variation_stocks_on_product_variation_id", using: :btree

end
