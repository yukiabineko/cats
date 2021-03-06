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

ActiveRecord::Schema.define(version: 20191018225629) do

  create_table "bases", force: :cascade do |t|
    t.float "data_age"
    t.float "min_weight"
    t.float "max_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cats", force: :cascade do |t|
    t.string "cat_name", null: false
    t.binary "cat_image"
    t.string "cat_sex"
    t.float "cat_weight", null: false
    t.integer "cat_age", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cats_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.boolean "save_check"
    t.string "facility_name"
    t.string "prefectures"
    t.string "phone_number"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "message_content"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_messages_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "post_title", null: false
    t.string "post_content", null: false
    t.string "category"
    t.boolean "public", default: true
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "serch_date"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "records", force: :cascade do |t|
    t.date "save_date"
    t.string "ideal_weight"
    t.float "result_weight"
    t.string "result"
    t.integer "cat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cat_id"], name: "index_records_on_cat_id"
  end

  create_table "replies", force: :cascade do |t|
    t.string "reply_content"
    t.integer "user_id"
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_replies_on_message_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "plan_date"
    t.string "plan_content"
    t.integer "cat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cat_id"], name: "index_schedules_on_cat_id"
  end

  create_table "users", force: :cascade do |t|
    t.binary "image"
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "info"
  end

end
