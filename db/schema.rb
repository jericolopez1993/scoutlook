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

ActiveRecord::Schema.define(version: 2020_03_05_035229) do

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
    t.string "annual_value"
    t.boolean "status"
    t.datetime "date_opened"
    t.datetime "date_closed"
    t.text "other_notes"
    t.integer "carrier_id"
    t.integer "shipper_id"
    t.date "date_stamp"
    t.integer "user_id"
    t.string "campaign_name", default: ""
    t.bigint "carrier_contact_id"
    t.bigint "shipper_contact_id"
    t.string "loads_per_week"
    t.string "outcome"
    t.string "reason"
    t.text "notes"
    t.string "reason_other"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "load_numbers"
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

  create_table "carr_demo", id: false, force: :cascade do |t|
    t.text "carrier_name"
    t.text "current_tier"
    t.text "previous_tier"
    t.text "highest_tier"
    t.text "highest_tier_date"
    t.float "gross_margin"
    t.float "load_last_week"
    t.float "load_last_month"
    t.float "load_last_3_months"
    t.float "load_last_6_months"
    t.text "mcnum"
    t.text "phone1"
    t.text "phone2"
    t.text "prime status"
    t.text "owner"
    t.text "mc_number"
    t.bigint "days_since"
  end

  create_table "carr_new", id: false, force: :cascade do |t|
    t.text "carrier_name"
    t.text "contact"
    t.bigint "load_last_month"
    t.datetime "first_load_date"
    t.datetime "last_load_date"
    t.text "last_os"
    t.text "last_ds"
    t.float "gross_margin"
    t.text "mcnum"
    t.bigint "loads_lw"
    t.bigint "loads_2w"
    t.bigint "loads_3w"
    t.bigint "loads_4w"
    t.bigint "loads_5w"
    t.bigint "loads_6w"
    t.text "phone1"
    t.text "phone2"
    t.text "prime status"
    t.text "mc_number"
    t.text "owner"
  end

  create_table "carr_prom", id: false, force: :cascade do |t|
    t.text "carrier_name"
    t.text "current_tier"
    t.text "previous_tier"
    t.text "highest_tier"
    t.text "highest_tier_date"
    t.float "gross_margin"
    t.float "load_last_week"
    t.float "load_last_month"
    t.float "load_last_3_months"
    t.float "load_last_6_months"
    t.text "mcnum"
    t.text "highest_tier_reached"
    t.text "phone1"
    t.text "phone2"
    t.text "prime status"
    t.text "mc_number"
    t.text "owner"
  end

  create_table "carr_tier", id: false, force: :cascade do |t|
    t.text "mcnum"
    t.text "carr_name_5"
    t.text "tier"
    t.text "mc_number"
  end

  create_table "carrier_companies", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "company_type"
    t.string "phone_number"
    t.string "website"
    t.integer "carrier_id"
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
    t.string "primary_extension_number"
    t.string "secondary_extension_number"
    t.text "notes"
    t.boolean "primary_eligible_texting", default: false
    t.boolean "secondary_eligible_texting", default: false
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
    t.string "commodities"
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

  create_table "carrier_notes", force: :cascade do |t|
    t.integer "carrier_id"
    t.integer "user_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.text "find_loads"
    t.boolean "complete_record", default: false
    t.string "total_fleet_size"
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
    t.boolean "contract_rates", default: false
    t.integer "years_established"
    t.string "category"
    t.string "previous_mc_number"
    t.boolean "blacklisted", default: false
    t.date "c_reminder_date"
    t.integer "c_reminder_id"
    t.text "c_reminder_notes"
    t.string "c_reminder_interval"
    t.string "c_reminder_type"
    t.string "c_lane_destination"
    t.string "c_lane_origin"
    t.integer "c_lane_id"
    t.string "c_mc_latest_date_tier"
    t.integer "c_mc_latest_date_last_month"
    t.integer "c_mc_latest_date_last_6_months"
    t.integer "c_mc_latest_date_load_days"
    t.datetime "c_auditable_last_activity_date"
    t.boolean "interview", default: false
    t.boolean "wolfbyte", default: false
    t.string "c_carr_tier_tier"
    t.datetime "c_activity_date_opened"
    t.string "c_activity_campaign_name"
    t.string "c_activity_activity_type"
    t.boolean "c_activity_status"
    t.integer "c_carr_new_loads_lw"
    t.integer "c_carr_new_loads_2w"
    t.integer "c_carr_new_loads_3w"
    t.integer "c_carr_new_loads_4w"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "df", id: false, force: :cascade do |t|
    t.datetime "ship_date_1"
    t.text "cust_name_2"
    t.text "ship_city_3"
    t.text "cons_city_4"
    t.text "carr_name_5"
    t.text "carr_tel"
    t.float "carrier_total_6"
    t.text "carrier_currency_7"
    t.text "userchar3_8"
    t.text "inv_num_9"
    t.text "userchar4"
    t.float "customer_total_10"
    t.text "currency_11"
    t.text "salesperson_12"
    t.float "userchar2_13"
    t.float "userchar1_14"
    t.text "loadsh_num"
    t.float "cust_sys"
    t.float "carr_sys"
    t.float "grossmargin"
    t.float "exch_rate"
    t.text "cust_key"
    t.text "dispatcher"
    t.text "salesperson"
    t.bigint "slsploadcnt"
    t.text "mcnum"
    t.text "year"
    t.text "month"
    t.text "week"
    t.text "major_origin"
    t.text "major_dest"
    t.float "commission"
    t.float "commission_d"
    t.float "commission_s"
    t.float "commission_sd"
    t.float "gp_not_commission"
    t.float "usd_cust_sys"
    t.float "usd_carr_sys"
    t.float "usd_grossmargin"
    t.float "usd_commission"
    t.float "usd_commission_d"
    t.float "usd_commission_s"
    t.float "usd_commission_sd"
    t.float "usd_gp_not_commission"
    t.text "carrier_class"
    t.text "carrier_class2"
    t.text "carrier_class3"
    t.text "carrier_class4"
    t.float "days_since"
    t.float "Unnamed: 0"
    t.text "route"
    t.float "lengthInMeters"
    t.float "travelTimeInSeconds"
    t.float "lengthInMiles"
    t.bigint "count"
    t.float "ttt_rpm"
    t.float "bill_rpm"
  end

  create_table "df_loads", id: false, force: :cascade do |t|
    t.text "load_num"
    t.datetime "ship_date"
    t.text "customer"
    t.text "origin"
    t.text "os"
    t.text "destination"
    t.text "ds"
    t.text "mc_num"
    t.text "carrier"
    t.text "curr"
    t.float "ttt"
    t.float "billing"
    t.float "mileage"
    t.float "ttt_rpm"
    t.float "bill_rpm"
    t.float "gm"
    t.text "gmper"
    t.float "cust_sys"
    t.float "carr_sys"
    t.float "gross_margin"
    t.float "exchange_rate"
    t.text "sales"
    t.text "dispatch"
    t.text "truck"
  end

  create_table "load_tiles", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "origin"
    t.string "destination"
    t.text "details"
    t.integer "carrier_id"
    t.integer "shipper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "load_date"
    t.integer "priority"
    t.integer "salesperson_id"
    t.integer "bill_rate"
    t.string "origin_city"
    t.string "destination_city"
    t.integer "picks", default: 1
    t.integer "drops", default: 1
    t.string "pu_time"
    t.string "pu_general_time"
    t.date "del_date"
    t.string "del_time"
    t.string "del_general_time"
    t.boolean "teams", default: false
    t.integer "truck_tile_id"
    t.integer "tile_tab_id"
  end

  create_table "mailings", force: :cascade do |t|
    t.string "recipient"
    t.string "cc"
    t.string "bcc"
    t.string "sender"
    t.string "subject"
    t.text "content_body"
    t.integer "user_id"
    t.boolean "sent", default: false
    t.boolean "trash", default: false
    t.boolean "archive", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "inbox", default: false
    t.string "status"
    t.datetime "date_sent"
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

  create_table "mc_latest_date", id: false, force: :cascade do |t|
    t.text "mcnum"
    t.datetime "ship_date_1"
    t.float "loadsh_num"
    t.float "loadsh_num_6mon"
    t.text "Tier"
  end

  create_table "messages", force: :cascade do |t|
    t.string "recipient"
    t.string "sender"
    t.text "content_body"
    t.integer "user_id"
    t.boolean "sent", default: false
    t.boolean "trash", default: false
    t.boolean "archive", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "inbox", default: false
    t.integer "carrier_id"
    t.integer "shipper_id"
  end

  create_table "rates", force: :cascade do |t|
    t.string "rate_type"
    t.integer "parent_id"
    t.string "rate_level"
    t.string "effective_to"
    t.string "effective_from"
    t.string "freight_desc"
    t.string "freight_classification"
    t.string "transit_time"
    t.string "minimum_density"
    t.integer "activity_id"
    t.string "origin_city", default: ""
    t.string "origin_state", default: ""
    t.string "origin_country", default: ""
    t.string "destination_city", default: ""
    t.string "destination_state", default: ""
    t.string "destination_country", default: ""
    t.integer "user_id"
    t.string "miles"
    t.integer "picks"
    t.integer "drops"
    t.string "team"
    t.string "commodities"
    t.decimal "bid"
    t.decimal "ask"
    t.decimal "cost"
    t.string "money_currency"
    t.text "notes"
    t.string "mc_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.integer "carrier_id"
    t.integer "shipper_id"
    t.integer "carrier_contact_id"
    t.integer "shipper_contact_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "carrier_id"
    t.integer "shipper_id"
    t.integer "activity_id"
    t.integer "user_id"
    t.date "reminder_date"
    t.integer "reminder_interval", default: 0
    t.boolean "recurring", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "last_reminded"
    t.text "notes"
    t.string "reminder_type"
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

  create_table "shipper_companies", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "company_type"
    t.string "phone_number"
    t.string "website"
    t.integer "shipper_id"
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
    t.string "primary_extension_number"
    t.string "secondary_extension_number"
    t.text "notes"
    t.boolean "primary_eligible_texting", default: false
    t.boolean "secondary_eligible_texting", default: false
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
    t.string "commodities"
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
    t.string "receiving_day"
    t.integer "receiving_hour"
    t.string "shipping_day"
    t.integer "shipping_hour"
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
    t.string "blue_book_score"
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
    t.integer "years_established"
    t.date "c_reminder_date"
    t.integer "c_reminder_id"
    t.text "c_reminder_notes"
    t.string "c_reminder_interval"
    t.string "c_reminder_type"
    t.string "c_lane_destination"
    t.string "c_lane_origin"
    t.integer "c_lane_id"
    t.datetime "c_auditable_last_activity_date"
  end

  create_table "tile_tabs", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "truck_tiles", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "origin"
    t.string "destination"
    t.text "details"
    t.integer "carrier_id"
    t.integer "shipper_id"
    t.date "load_date"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dispatcher_id"
    t.integer "bill_rate"
    t.integer "pu_time"
    t.string "pu_general_time"
    t.date "del_date"
    t.integer "del_time"
    t.string "del_general_time"
    t.boolean "teams", default: false
    t.integer "tile_tab_id"
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
    t.text "email_signature", default: "        <table class=\"m_-3783900543240753759MsoNormalTable\" style=\"color: #222222; font-family: Arial, Helvetica, sans-serif; font-size: small; border-collapse: collapse;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n        <tbody>\n        <tr style=\"height: 72.55pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 126.15pt; border-top: none; border-bottom: none; border-left: none; border-image: initial; border-right: 1pt solid red; padding: 0cm 5.4pt; height: 72.55pt;\" valign=\"top\" width=\"168\">\n        <table class=\"m_-3783900543240753759MsoNormalTable\" style=\"width: 116.1pt;\" border=\"0\" width=\"155\" cellspacing=\"0\" cellpadding=\"0\">\n        <tbody>\n        <tr style=\"height: 13.3pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 116.1pt; padding: 0cm; height: 13.3pt;\" width=\"155\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; text-align: center;\" align=\"center\"><strong><span style=\"font-size: 14pt; font-family: Arial, sans-serif; color: black;\">{{Full Name}}</span></strong><u></u><u></u></p>\n        </td>\n        </tr>\n        <tr style=\"height: 7pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 116.1pt; padding: 0cm; height: 7pt;\" width=\"155\">\n        <p class=\"MsoNormal\" style=\"margin: 0px;\"><strong><span style=\"font-size: 5pt; font-family: Arial, sans-serif; color: black;\">&nbsp;</span></strong><u></u><u></u></p>\n        </td>\n        </tr>\n        <tr style=\"height: 43.7pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 116.1pt; padding: 0cm; height: 43.7pt;\" width=\"155\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; text-align: center; line-height: 14.95px;\" align=\"center\"><a style=\"color: #1155cc;\" href=\"http://scoutlogistics.com/\" target=\"_blank\" rel=\"noopener\" data-saferedirecturl=\"https://www.google.com/url?q=http://scoutlogistics.com/&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNFbnVmtYqeDo0aN1UsYBjs8QtKT5Q\"><span style=\"color: windowtext; text-decoration-line: none;\"><img style=\"width: 202px !important; height: 49px !important;\" src=\"https://scoutlook-staging.opinionated.software/assets/email_template/scout-logo-425a26c49085fb13f980d19258eff7714fef0118fdb4df2f41309ff99df083bf.png\" alt=\"scout.png\" border=\"0\" /></span></a><u></u><u></u></p>\n        </td>\n        </tr>\n        </tbody>\n        </table>\n        </td>\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 227.3pt; padding: 0cm 5.4pt; height: 72.55pt;\" colspan=\"2\" valign=\"top\" width=\"303\">\n        <table class=\"m_-3783900543240753759MsoNormalTable\" style=\"width: 215.65pt;\" border=\"0\" width=\"288\" cellspacing=\"0\" cellpadding=\"0\">\n        <tbody>\n        <tr style=\"height: 11.65pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 11.65pt;\" width=\"288\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><strong><span style=\"font-size: 9pt; line-height: 13.8px; font-family: Arial, sans-serif; color: black;\">{{Title}}</span></strong><u></u><u></u></p>\n        </td>\n        </tr>\n        <tr style=\"height: 12.5pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 12.5pt;\" width=\"288\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><strong><span style=\"font-size: 9pt; line-height: 13.8px; font-family: Arial, sans-serif; color: black;\">Scout Logistics Corporation<u></u><u></u></span></strong></p>\n        </td>\n        </tr>\n        <tr style=\"height: 3.9pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 3.9pt;\" width=\"288\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><span style=\"font-size: 3pt; line-height: 4.6px; font-family: Arial, sans-serif; color: black;\">&nbsp;</span><u></u><u></u></p>\n        </td>\n        </tr>\n        <tr style=\"height: 32.8pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 32.8pt;\" width=\"288\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;\">Phone:</span></strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;\">&nbsp;{{Phone}}<u></u><u></u></span></p>\n        <p class=\"MsoNormal\" style=\"color: #c00000 !important; margin: 0px; line-height: 14.95px;\"><strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; \">Direct</span></strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif;\">: {{Direct}}<u></u><u></u></span></p>\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;\">Toll Free:</span></strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;\">&nbsp;{{Toll Free}}<u></u><u></u></span></p>\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;\">Cell:</span></strong><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;\">&nbsp;{{Cell}}<u></u><u></u></span></p>\n        </td>\n        </tr>\n        <tr>\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm;\" width=\"288\">&nbsp;</td>\n        </tr>\n        <tr style=\"height: 10.9pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 10.9pt;\" width=\"288\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; line-height: 14.95px;\"><a style=\"color: #1155cc;\" href=\"mailto:\" target=\"_blank\" rel=\"noopener\"><span style=\"font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: blue;\">{{E-Mail Address}}</span></a><u></u><u></u></p>\n        </td>\n        </tr>\n        </tbody>\n        </table>\n        </td>\n        </tr>\n        <tr style=\"height: 43.7pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 344.25pt; border-right: none; border-bottom: none; border-left: none; border-image: initial; border-top: 1pt solid red; padding: 0cm 5.4pt; height: 43.7pt;\" colspan=\"2\" width=\"459\">\n        <p class=\"MsoNormal\" style=\"margin: 0px;\">&nbsp;<a style=\"color: #1155cc;\" href=\"https://www.bestmanagedcompanies.ca/en/Pages/Home.aspx\" target=\"_blank\" rel=\"noopener\" data-saferedirecturl=\"https://www.google.com/url?q=https://www.bestmanagedcompanies.ca/en/Pages/Home.aspx&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNEr8SxfsYq20EXSAi98sbF7nmyQ5g\"><span style=\"color: windowtext; text-decoration-line: none;\"><img style=\"width: 94px !important; height: 38px !important;\" src=\"https://scoutlook-staging.opinionated.software/assets/email_template/best-manage-companies-a06bd3b8f706efed0a357fc6c818bb48aeae4f2b436201c77614c5eda69e7685.jpg\" alt=\"deloitt\" border=\"0\" /></span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style=\"color: #1155cc;\" href=\"https://www.facebook.com/pages/Scout-Logistics/194502150588319\" target=\"_blank\" rel=\"noopener\" data-saferedirecturl=\"https://www.google.com/url?q=https://www.facebook.com/pages/Scout-Logistics/194502150588319&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNHNRrVAjgjPX_9bp205GTH4iHxpWQ\"><span style=\"color: windowtext; text-decoration-line: none;\"><img style=\"width: 34px !important; height: 34px !important;\" src=\"https://scoutlook-staging.opinionated.software/assets/email_template/facebook-80e80df9ba2395b3ccd8156c17f47a95633f281103679c4e6a0189ebcb56d220.jpg\" alt=\"facebook\" border=\"0\" /></span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style=\"color: #1155cc;\" href=\"https://www.linkedin.com/company/scout-logistics-corporation?trk=company_logo\" target=\"_blank\" rel=\"noopener\" data-saferedirecturl=\"https://www.google.com/url?q=https://www.linkedin.com/company/scout-logistics-corporation?trk%3Dcompany_logo&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNGV6B5fwhVVDd_D9cKRhP4YXrsI0w\"><span style=\"color: windowtext; text-decoration-line: none;\"><img style=\"width: 34px !important; height: 34px !important;\" src=\"https://scoutlook-staging.opinionated.software/assets/email_template/linkedin-7f7eea2a78b99e4fb17ab4021e7f9f9bec32b16a1ffd61d365d07b322f9d79ce.jpg\" alt=\"linkedin\" title=\"Image: https://scoutlook-staging.opinionated.software/assets/email_template/linkedin-7f7eea2a78b99e4fb17ab4021e7f9f9bec32b16a1ffd61d365d07b322f9d79ce.jpg\" border=\"0\" /></span></a>&nbsp;&nbsp;<wbr />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style=\"color: #1155cc;\" href=\"http://www.twitter.com/scoutlogistics/\" target=\"_blank\" rel=\"noopener\" data-saferedirecturl=\"https://www.google.com/url?q=http://www.twitter.com/scoutlogistics/&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNHNp7s0zkxV-wsGpoM7nLGCbmTLFw\"><span style=\"color: windowtext; text-decoration-line: none;\"><img style=\"width: 34px !important; height: 34px !important;\" src=\"https://scoutlook-staging.opinionated.software/assets/email_template/twitter-0be553480fcde0e72df49b7f7f352111a0c5863764b0903dcb165b8e15fa1235.jpg\" alt=\"twitter\" border=\"0\" /></span></a><u></u><u></u></p>\n        </td>\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 9.25pt; padding: 0cm; height: 43.7pt;\" width=\"12\">\n        <p class=\"MsoNormal\" style=\"margin: 0px;\">&nbsp;<u></u><u></u></p>\n        </td>\n        </tr>\n        <tr style=\"height: 24.2pt;\">\n        <td style=\"font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 344.25pt; padding: 0cm 5.4pt; height: 24.2pt;\" colspan=\"2\" width=\"459\">\n        <p class=\"MsoNormal\" style=\"margin: 0px; text-align: center;\" align=\"center\"><span style=\"font-size: 8pt; font-family: Arial, sans-serif; color: #943634;\">\"The one thing that doesn''t abide by majority rule is a person''s conscience.\"<u></u><u></u></span></p>\n        <p class=\"MsoNormal\" style=\"margin: 0px; text-align: center;\" align=\"center\"><span style=\"font-size: 8pt; font-family: Arial, sans-serif; color: #943634;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Atticus Finch \"To Kill a Mocking Bird\"</span></p>\n        </td>\n        </tr>\n        </tbody>\n        </table>\n"
    t.string "carrier_categories"
    t.string "shipper_categories"
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
