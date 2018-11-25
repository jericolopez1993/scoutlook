class CreateCarriers < ActiveRecord::Migration[5.2]
  def change

    create_table "carrier_contacts" do |t|
      t.string "title"
      t.string "email"
      t.string "work_phone"
      t.string "home_phone"
      t.integer "carrier_id"
      t.string "last_name"
      t.boolean "same_ho", default: false
      t.string "first_name"
      t.string "linkedin_link"
      t.integer "location_id"
      t.timestamps
    end

    create_table "carrier_locations" do |t|
      t.string "carrier_id"
      t.string "name"
      t.string "loc_type"
      t.text "special_instructions"
      t.string "phone"
      t.integer "poc_id"
      t.integer "soc_id"
      t.boolean "same_ho", default: false
      t.integer "location_id"
      t.timestamps
    end

    create_table "carriers" do |t|
      t.integer "relationship_owner"
      t.string "company_name"
      t.string "parent_id"
      t.integer "sales_priority"
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
      t.timestamps
    end

    add_column :locations, :carrier_id, :integer
  end
end
