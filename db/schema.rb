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

ActiveRecord::Schema.define(version: 2018_12_20_030634) do

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

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "carrier_activities", force: :cascade do |t|
    t.string "activity_type"
    t.string "engagement_type"
    t.string "annual_value"
    t.boolean "status"
    t.datetime "date_opened"
    t.datetime "date_closed"
    t.text "other_notes"
    t.integer "outcome_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carrier_id"
    t.date "date_stamp"
    t.integer "user_id"
    t.string "campaign_name", default: ""
  end

  create_table "carrier_activity_outcomes", force: :cascade do |t|
    t.string "outcome"
    t.string "reason"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carrier_contacts", force: :cascade do |t|
    t.string "title"
    t.string "email"
    t.integer "carrier_id"
    t.string "last_name"
    t.boolean "same_ho", default: false
    t.string "first_name"
    t.string "linkedin_link"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_type"
    t.boolean "adm", default: false
    t.string "primary_phone", default: ""
    t.string "primary_phone_type", default: ""
    t.string "secondary_phone", default: ""
    t.string "secondary_phone_type", default: ""
    t.string "city", default: ""
    t.string "address", default: ""
    t.string "state", default: ""
    t.string "postal", default: ""
    t.string "country", default: ""
  end

  create_table "carrier_lanes", force: :cascade do |t|
    t.string "lane_origin"
    t.string "lane_destination"
    t.integer "truck_per_week"
    t.string "preferred_load_day"
    t.text "notes"
    t.integer "carrier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lane_priority"
    t.boolean "prefer_team", default: false
  end

  create_table "carrier_locations", force: :cascade do |t|
    t.string "name"
    t.string "city", default: ""
    t.string "address", default: ""
    t.string "state", default: ""
    t.string "postal", default: ""
    t.string "country", default: ""
    t.string "loc_type"
    t.string "phone"
    t.boolean "is_origin", default: false
    t.boolean "is_destination", default: false
    t.integer "carrier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carrier_rates", force: :cascade do |t|
    t.string "rate_type"
    t.integer "parent_id"
    t.string "rate_level"
    t.string "effective_to"
    t.string "effective_from"
    t.string "freight_desc"
    t.string "freight_classification"
    t.string "transit_time"
    t.string "minimum_density"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carrier_id"
    t.string "origin_city", default: ""
    t.string "origin_state", default: ""
    t.string "origin_country", default: ""
    t.string "destination_city", default: ""
    t.string "destination_state", default: ""
    t.string "destination_country", default: ""
    t.integer "user_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "company_name"
    t.string "parent_id"
    t.string "phone"
    t.string "industry"
    t.string "primary_industry"
    t.string "hazardous"
    t.string "food_grade"
    t.decimal "freight_revenue"
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
    t.string "annual_revenue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "score_card"
    t.string "freight_guard"
    t.integer "years_in_business", default: 0
    t.integer "owner_operators", default: 0
    t.integer "reefers", default: 0
    t.integer "dry_vans", default: 0
    t.integer "flat_beds", default: 0
    t.integer "teams", default: 0
    t.boolean "contract_rates", default: false
    t.text "find_loads"
    t.boolean "complete_record", default: false
    t.string "total_fleet_size"
    t.string "website"
    t.string "linkedin"
    t.string "sales_priority"
    t.integer "last_contact_by"
    t.date "last_contact"
    t.integer "relationship_owner"
    t.integer "power_units", default: 0
    t.integer "company_drivers", default: 0
    t.integer "load_last_month", default: 0
    t.integer "load_last_6_month", default: 0
    t.boolean "approved", default: false
    t.string "mc_number"
    t.integer "carrier_setup"
    t.date "date_approved"
    t.date "last_load_date"
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
    t.boolean "variance_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shipment_entry"
    t.string "invoice_number"
    t.string "own_status"
  end

  create_table "master_signals", force: :cascade do |t|
    t.string "signal_type"
    t.date "signal_date"
    t.integer "client_id"
    t.integer "client_contact_id"
    t.integer "rate_id"
    t.date "start_date"
    t.date "end_date"
    t.string "duration"
    t.integer "volume"
    t.string "uom"
    t.string "per"
    t.string "capacity_type"
    t.string "max_origin"
    t.string "max_destination"
    t.string "desired_rate"
    t.text "notes"
    t.boolean "same_origin"
    t.boolean "same_origin_hoc"
    t.boolean "same_destination"
    t.boolean "same_destination_hoc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "origin_location_id"
    t.integer "destination_location_id"
  end

  create_table "read_marks", id: :serial, force: :cascade do |t|
    t.string "readable_type", null: false
    t.integer "readable_id"
    t.string "reader_type", null: false
    t.integer "reader_id"
    t.datetime "timestamp"
    t.index ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id"
    t.index ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true
    t.index ["reader_type", "reader_id"], name: "index_read_marks_on_reader_type_and_reader_id"
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
    t.integer "user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "header"
    t.date "shipment_date"
    t.string "tracking_number"
    t.string "terms"
    t.decimal "distance"
    t.integer "pieces"
    t.integer "pallets"
    t.decimal "declared_weight"
    t.decimal "billed_weight"
    t.decimal "raw_weight"
    t.string "service_mode"
    t.decimal "billed_rate"
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
    t.string "billed_rate_unit"
    t.string "account_number"
    t.text "notes"
    t.integer "origin_location_id"
    t.integer "destination_location_id"
    t.string "money_currency"
    t.date "received_date"
    t.integer "transit_time"
    t.string "own_type"
    t.string "shipment_status"
    t.string "client_reference"
  end

  create_table "shipper_activities", force: :cascade do |t|
    t.string "activity_type"
    t.string "engagement_type"
    t.string "annual_value"
    t.boolean "status"
    t.datetime "date_opened"
    t.datetime "date_closed"
    t.text "other_notes"
    t.integer "outcome_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipper_id"
    t.date "date_stamp"
    t.integer "user_id"
    t.string "campaign_name", default: ""
  end

  create_table "shipper_activity_outcomes", force: :cascade do |t|
    t.string "outcome"
    t.string "reason"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipper_contacts", force: :cascade do |t|
    t.string "title"
    t.string "email"
    t.integer "shipper_id"
    t.string "last_name"
    t.boolean "same_ho", default: false
    t.string "first_name"
    t.string "linkedin_link"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_type"
    t.boolean "adm", default: false
    t.string "primary_phone", default: ""
    t.string "primary_phone_type", default: ""
    t.string "secondary_phone", default: ""
    t.string "secondary_phone_type", default: ""
    t.string "city", default: ""
    t.string "address", default: ""
    t.string "state", default: ""
    t.string "postal", default: ""
    t.string "country", default: ""
  end

  create_table "shipper_lanes", force: :cascade do |t|
    t.string "lane_origin"
    t.string "lane_destination"
    t.integer "truck_per_week"
    t.string "preferred_load_day"
    t.text "notes"
    t.integer "shipper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lane_priority"
    t.boolean "prefer_team", default: false
  end

  create_table "shipper_locations", force: :cascade do |t|
    t.string "name"
    t.string "city", default: ""
    t.string "address", default: ""
    t.string "state", default: ""
    t.string "postal", default: ""
    t.string "country", default: ""
    t.string "loc_type"
    t.string "phone"
    t.boolean "is_origin", default: false
    t.boolean "is_destination", default: false
    t.integer "shipper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipper_rates", force: :cascade do |t|
    t.string "rate_type"
    t.integer "parent_id"
    t.string "rate_level"
    t.string "effective_to"
    t.string "effective_from"
    t.string "freight_desc"
    t.string "freight_classification"
    t.string "transit_time"
    t.string "minimum_density"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipper_id"
    t.string "origin_city", default: ""
    t.string "origin_state", default: ""
    t.string "origin_country", default: ""
    t.string "destination_city", default: ""
    t.string "destination_state", default: ""
    t.string "destination_country", default: ""
    t.integer "user_id"
  end

  create_table "shippers", force: :cascade do |t|
    t.string "company_name"
    t.string "parent_id"
    t.string "phone"
    t.string "industry"
    t.string "primary_industry"
    t.string "hazardous"
    t.string "food_grade"
    t.decimal "freight_revenue"
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
    t.string "annual_revenue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "years_in_business", default: 0
    t.boolean "complete_record", default: false
    t.string "website"
    t.string "linkedin"
    t.string "sales_priority"
    t.string "shipper_type"
    t.boolean "control_freight", default: false
    t.string "loads_per_month"
    t.string "spend_per_year"
    t.string "commodities"
    t.text "commodities_notes"
    t.integer "blue_book_score"
    t.string "blue_book_url"
    t.string "buying_criteria"
    t.boolean "works_with_brokers", default: false
    t.string "price_sensitivity"
    t.text "challenges"
    t.text "current_carrier_mix"
    t.boolean "prefer_teams", default: false
    t.integer "last_contact_by"
    t.date "last_contact"
    t.integer "relationship_owner"
    t.integer "load_last_month", default: 0
    t.integer "load_last_6_month", default: 0
    t.boolean "approved", default: false
    t.date "date_approved"
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
    t.integer "carrier_contact_id"
    t.integer "shipper_contact_id"
    t.boolean "ro", default: false
    t.boolean "cs", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
