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

ActiveRecord::Schema.define(version: 2021_03_22_171413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "changes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_changes_on_user_id"
  end

  create_table "codelist_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.string "lang", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "identifier"
    t.bigint "codelist_id"
    t.index ["codelist_id"], name: "index_codelist_items_on_codelist_id"
  end

  create_table "codelists", force: :cascade do |t|
    t.integer "identifier", null: false
    t.string "name", null: false
    t.string "description", default: "", null: false
    t.string "lang", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "system_settings", force: :cascade do |t|
    t.string "key", null: false
    t.string "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_system_settings_on_key"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "changes", "users"
  add_foreign_key "codelist_items", "codelists"
end
