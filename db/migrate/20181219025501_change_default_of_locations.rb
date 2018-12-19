class ChangeDefaultOfLocations < ActiveRecord::Migration[5.2]
  def change
      change_column :carrier_locations, :city, :string, default: ""
      change_column :carrier_locations, :address, :string, default: ""
      change_column :carrier_locations, :state, :string, default: ""
      change_column :carrier_locations, :postal, :string, default: ""
      change_column :carrier_locations, :country, :string, default: ""
      change_column :shipper_locations, :city, :string, default: ""
      change_column :shipper_locations, :address, :string, default: ""
      change_column :shipper_locations, :state, :string, default: ""
      change_column :shipper_locations, :postal, :string, default: ""
      change_column :shipper_locations, :country, :string, default: ""
  end
end
