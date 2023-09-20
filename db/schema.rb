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

ActiveRecord::Schema[7.0].define(version: 2023_09_16_155414) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "account_login_change_keys", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.citext "email", null: false
    t.string "password_hash"
    t.string "api_token"
    t.string "timezone", default: "UTC"
    t.index ["email"], name: "index_accounts_on_email", unique: true, where: "(status = ANY (ARRAY[1, 2]))"
  end

  create_table "appointment_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_appointment_kinds_on_account_id"
    t.index ["name"], name: "index_appointment_kinds_on_name", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.tstzrange "time_range"
    t.bigint "appointment_kind_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_appointments_on_account_id"
    t.index ["appointment_kind_id"], name: "index_appointments_on_appointment_kind_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.string "hex_color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "summaries", force: :cascade do |t|
    t.date "day", null: false
    t.interval "total_time", default: "PT0S", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "raw_hits", default: []
    t.jsonb "languages"
    t.jsonb "projects"
    t.index ["account_id", "day"], name: "index_summaries_on_account_id_and_day", unique: true
    t.index ["account_id"], name: "index_summaries_on_account_id"
    t.index ["languages"], name: "index_summaries_on_languages", using: :gin
    t.index ["projects"], name: "index_summaries_on_projects", using: :gin
    t.index ["raw_hits"], name: "index_summaries_on_raw_hits", using: :gin
  end

  add_foreign_key "account_login_change_keys", "accounts", column: "id"
  add_foreign_key "account_password_reset_keys", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "account_verification_keys", "accounts", column: "id"
  add_foreign_key "appointment_kinds", "accounts"
  add_foreign_key "appointments", "accounts"
  add_foreign_key "appointments", "appointment_kinds"
  add_foreign_key "summaries", "accounts"
end
