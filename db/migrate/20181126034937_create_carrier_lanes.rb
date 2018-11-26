class CreateCarrierLanes < ActiveRecord::Migration[5.2]
  def change
    create_table :carrier_lanes do |t|
      t.string :lane_priority
      t.string :lane_origin
      t.string :lane_destination
      t.integer :truck_per_week
      t.string :preferred_load_day
      t.text :notes
      t.integer :carrier_id

      t.timestamps
    end
  end
end
