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

ActiveRecord::Schema.define(version: 2019_10_28_060514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "portion"
    t.text "tips"
    t.text "reference"
    t.integer "cook_times"
    t.integer "required_time"
    t.integer "popularity"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "cook_times"], name: "index_dishes_on_user_id_and_cook_times"
    t.index ["user_id", "created_at"], name: "index_dishes_on_user_id_and_created_at"
    t.index ["user_id", "popularity"], name: "index_dishes_on_user_id_and_popularity"
    t.index ["user_id", "required_time"], name: "index_dishes_on_user_id_and_required_time"
    t.index ["user_id"], name: "index_dishes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "introduction"
    t.string "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
  end

  add_foreign_key "dishes", "users"
end
