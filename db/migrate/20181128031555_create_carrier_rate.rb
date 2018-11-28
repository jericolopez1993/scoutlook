class CreateCarrierRate < ActiveRecord::Migration[5.2]
  def change
    create_table "carrier_rates", force: :cascade do |t|
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
      t.integer "carrier_id"
    end
  end
end
