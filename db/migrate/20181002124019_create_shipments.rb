class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.integer :header
      t.date :shipment_date
      t.string :tracking_number
      t.string :terms
      t.integer :origin_id
      t.integer :origin_location_id
      t.integer :destination_id
      t.integer :destination_location_id
      t.decimal :distance
      t.integer :pieces
      t.integer :pallets
      t.decimal :unit_of_weight
      t.decimal :declared_weight
      t.decimal :billed_weight
      t.decimal :raw_weight
      t.string :service_mode
      t.decimal :billed_rate
      t.string :billed_rate_unit
      t.decimal :surcharge_ontario
      t.decimal :surcharge_non_conveyables
      t.decimal :surcharge_non_vault
      t.decimal :surchange_multi_piece
      t.decimal :surcharge_fuel
      t.decimal :surcharge_weight
      t.decimal :gst_hst_tax
      t.decimal :total_charge
      t.decimal :total_charge_with_tax

      t.timestamps
    end
  end
end
