class CreateShipperModels < ActiveRecord::Migration[5.2]
  def change
    create_table "shipper_contacts", force: :cascade do |t|
      t.string "title"
      t.string "email"
      t.string "work_phone"
      t.string "home_phone"
      t.integer "shipper_id"
      t.string "last_name"
      t.boolean "same_ho", default: false
      t.string "first_name"
      t.string "linkedin_link"
      t.integer "location_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "contact_type"
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
    end

    create_table "shipper_locations", force: :cascade do |t|
      t.string "name"
      t.string "city"
      t.string "address"
      t.string "state"
      t.string "postal"
      t.string "country"
      t.string "loc_type"
      t.string "phone"
      t.boolean "is_origin", default: false
      t.boolean "is_destination", default: false
      t.integer "shipper_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "shippers", force: :cascade do |t|
      t.integer "relationship_owner"
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
      t.string "contract_rates"
      t.text "find_loads"
      t.boolean "complete_record", default: false
      t.string "total_fleet_size"
      t.string "website"
      t.string "linkedin"
      t.string "sales_priority"
    end

    create_table "shipper_rates", force: :cascade do |t|
      t.string "rate_type"
      t.integer "parent_id"
      t.string "rate_level"
      t.integer "rep_id"
      t.string "effective_to"
      t.string "effective_from"
      t.string "freight_desc"
      t.string "freight_classification"
      t.string "transit_time"
      t.string "minimum_density"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "origin_location_id"
      t.integer "destination_location_id"
      t.integer "shipper_id"
    end
  end
end
