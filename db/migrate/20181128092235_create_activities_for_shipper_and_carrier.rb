class CreateActivitiesForShipperAndCarrier < ActiveRecord::Migration[5.2]
  def change
    drop_table :activities
    drop_table :activity_outcomes
    create_table "carrier_activities", force: :cascade do |t|
      t.string "activity_type"
      t.string "engagement_type"
      t.integer "rep_id"
      t.string "annual_value"
      t.boolean "status"
      t.datetime "date_opened"
      t.datetime "date_closed"
      t.text "other_notes"
      t.integer "outcome_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "carrier_id"
    end
    create_table "carrier_activity_outcomes", force: :cascade do |t|
      t.string "outcome"
      t.string "reason"
      t.text "notes"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "shipper_activities", force: :cascade do |t|
      t.string "activity_type"
      t.string "engagement_type"
      t.integer "rep_id"
      t.string "annual_value"
      t.boolean "status"
      t.datetime "date_opened"
      t.datetime "date_closed"
      t.text "other_notes"
      t.integer "outcome_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "shipper_id"
    end
    create_table "shipper_activity_outcomes", force: :cascade do |t|
      t.string "outcome"
      t.string "reason"
      t.text "notes"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
