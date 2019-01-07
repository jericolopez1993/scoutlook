class RecreateActivities < ActiveRecord::Migration[5.2]
  def up
    create_table :activities do |t|
      t.string :activity_type
      t.string :engagement_type
      t.string :annual_value
      t.boolean :status
      t.datetime :date_opened
      t.datetime :date_closed
      t.text :other_notes
      t.integer :carrier_id
      t.integer :shipper_id
      t.date :date_stamp
      t.integer :user_id
      t.string :campaign_name, default: ""
      t.bigint :carrier_contact_id
      t.bigint :shipper_contact_id
      t.string :loads_per_week
      t.string :outcome
      t.string :reason
      t.text :notes
      t.string :reason_other

      t.timestamps
    end
  end

  def down
    drop_table :activities
  end
end
