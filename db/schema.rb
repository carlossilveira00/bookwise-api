# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_17_103156) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "pages"
    t.string "author"
    t.string "category"
    t.string "thumbnail_url"
    t.string "publisher"
    t.string "ISBN"
    t.date "published_date"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_library_id", null: false
    t.string "title"
    t.text "body"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
    t.index ["user_library_id"], name: "index_notes_on_user_library_id"
  end

  create_table "user_libraries", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "user_id", null: false
    t.string "status"
    t.date "started_date"
    t.date "ended_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_user_libraries_on_book_id"
    t.index ["user_id"], name: "index_user_libraries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "notes", "user_libraries"
  add_foreign_key "notes", "users"
  add_foreign_key "user_libraries", "books"
  add_foreign_key "user_libraries", "users"
end
