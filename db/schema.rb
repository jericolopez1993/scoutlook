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

ActiveRecord::Schema.define(version: 2018_09_25_154344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_contacts", force: :cascade do |t|
    t.string "title"
    t.string "email"
    t.string "work_phone"
    t.string "home_phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal"
    t.string "country"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_locations", force: :cascade do |t|
    t.string "client_id"
    t.string "location_id"
    t.string "name"
    t.string "loc_type"
    t.text "special_instructions"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal"
    t.string "country"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "client_type"
    t.integer "relationship_owner"
    t.string "company_name"
    t.string "parent_id"
    t.integer "sales_priority"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal"
    t.string "country"
    t.string "phone"
    t.decimal "annual_revenue"
    t.string "industry"
    t.string "primary_industry"
    t.string "hazardous"
    t.string "food_grade"
    t.decimal "freight_revenue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pdm_id"
    t.integer "poc_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reps", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.date "date_of_hire"
    t.string "rep_id"
    t.string "parent_id"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
