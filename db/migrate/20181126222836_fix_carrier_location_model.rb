class FixCarrierLocationModel < ActiveRecord::Migration[5.2]
  def change
    drop_table :carrier_locations
    create_table :carrier_locations do |t|
      t.string :name
      t.string :city
      t.string :address
      t.string :state
      t.string :postal
      t.string :country
      t.string :loc_type
      t.string :phone
      t.boolean :is_origin, default: false
      t.boolean :is_destination, default: false
      t.integer :carrier_id
      t.timestamps
    end
  end
end
