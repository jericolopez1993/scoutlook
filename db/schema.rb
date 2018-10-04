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

ActiveRecord::Schema.define(version: 2018_10_04_070320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "activity_type"
    t.string "engagement_type"
    t.integer "client_id"
    t.integer "rep_id"
    t.string "annual_value"
    t.boolean "status"
    t.datetime "date_opened"
    t.datetime "date_closed"
    t.text "other_notes"
    t.integer "outcome_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_outcomes", force: :cascade do |t|
    t.string "outcome"
    t.string "reason"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string "name"
    t.boolean "same_ho", default: false
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
    t.integer "poc_id"
    t.integer "soc_id"
    t.boolean "same_ho", default: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "client_type"
    t.integer "relationship_owner"
    t.string "company_name"
    t.string "parent_id"
    t.integer "sales_priority"
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
    t.string "volume_intra"
    t.string "volume_inter"
    t.string "volume_to_usa"
    t.string "volume_from_usa"
    t.text "notes"
    t.string "credit_status"
    t.decimal "credit_approval"
    t.integer "origin"
    t.integer "destination"
    t.integer "head_office"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "master_invoices", force: :cascade do |t|
    t.string "shipment_type"
    t.integer "shipper_id"
    t.integer "carrier_id"
    t.string "master_account"
    t.date "single_invoice_date"
    t.date "invoicing_period_start"
    t.date "invoicing_period_end"
    t.decimal "total_charge"
    t.decimal "variance"
    t.boolean "variance_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shipment_entry"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "client_id"
    t.string "rate_type"
    t.integer "parent_id"
    t.string "rate_level"
    t.integer "rep_id"
    t.string "effective_to"
    t.string "effective_from"
    t.string "origin_city"
    t.string "origin_state"
    t.string "origin_country"
    t.string "destination_city"
    t.string "destination_state"
    t.string "destination_country"
    t.string "freight_desc"
    t.string "freight_classification"
    t.string "transit_time"
    t.string "minimum_density"
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

  create_table "shipments", force: :cascade do |t|
    t.integer "header"
    t.date "shipment_date"
    t.string "tracking_number"
    t.string "terms"
    t.integer "origin_id"
    t.integer "origin_location_id"
    t.integer "destination_id"
    t.integer "destination_location_id"
    t.decimal "distance"
    t.integer "pieces"
    t.integer "pallets"
    t.decimal "declared_weight"
    t.decimal "billed_weight"
    t.decimal "raw_weight"
    t.string "service_mode"
    t.decimal "billed_rate"
    t.string "billed_rate_unit"
    t.decimal "surcharge_ontario"
    t.decimal "surcharge_non_conveyables"
    t.decimal "surcharge_non_vault"
    t.decimal "surchange_multi_piece"
    t.decimal "surcharge_fuel"
    t.decimal "surcharge_weight"
    t.decimal "gst_hst_tax"
    t.decimal "total_charge"
    t.decimal "total_charge_with_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit_of_weight"
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
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
