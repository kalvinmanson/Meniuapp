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

ActiveRecord::Schema.define(version: 20171214055511) do

  create_table "apps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "public_key"
    t.string "private_key"
    t.string "domains"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_apps_on_user_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.boolean "place"
    t.boolean "plate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id"
    t.integer "months"
    t.integer "total"
    t.string "status"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_payments_on_place_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.string "name"
    t.string "slug"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.text "description"
    t.float "rank", limit: 24
    t.integer "views"
    t.float "lat", limit: 24
    t.float "lng", limit: 24
    t.date "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_file_name"
    t.string "cover_content_type"
    t.integer "cover_file_size"
    t.datetime "cover_updated_at"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.index ["category_id"], name: "index_places_on_category_id"
    t.index ["user_id"], name: "index_places_on_user_id"
  end

  create_table "plates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id"
    t.string "name"
    t.string "slug"
    t.text "content"
    t.boolean "favored"
    t.boolean "active"
    t.integer "price"
    t.string "tags"
    t.float "rank", limit: 24
    t.integer "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["place_id"], name: "index_plates_on_place_id"
  end

  create_table "quests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "quest"
    t.integer "visited_place"
    t.integer "visited_plate"
    t.float "lat", limit: 24
    t.float "lng", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_quests_on_user_id"
  end

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "app_id"
    t.string "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_tokens_on_app_id"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uid"
    t.string "provider"
    t.string "role"
    t.string "name"
    t.string "image"
    t.boolean "active"
    t.float "lat", limit: 24
    t.float "lng", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "plate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plate_id"], name: "index_visits_on_plate_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "place_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_votes_on_place_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "apps", "users"
  add_foreign_key "payments", "places"
  add_foreign_key "places", "categories"
  add_foreign_key "places", "users"
  add_foreign_key "plates", "places"
  add_foreign_key "quests", "users"
  add_foreign_key "tokens", "apps"
  add_foreign_key "tokens", "users"
  add_foreign_key "visits", "plates"
  add_foreign_key "visits", "users"
  add_foreign_key "votes", "places"
  add_foreign_key "votes", "users"
end
