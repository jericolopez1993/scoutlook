class ModifyCarrierRatesAndShipperRates < ActiveRecord::Migration[5.2]
  def change
      remove_column :carrier_rates, :origin_location_id
      remove_column :carrier_rates, :destination_location_id
      add_column :carrier_rates, :origin_city, :string, :default => ""
      add_column :carrier_rates, :origin_state, :string, :default => ""
      add_column :carrier_rates, :origin_country, :string, :default => ""
      add_column :carrier_rates, :destination_city, :string, :default => ""
      add_column :carrier_rates, :destination_state, :string, :default => ""
      add_column :carrier_rates, :destination_country, :string, :default => ""
      remove_column :shipper_rates, :origin_location_id
      remove_column :shipper_rates, :destination_location_id
      add_column :shipper_rates, :origin_city, :string, :default => ""
      add_column :shipper_rates, :origin_state, :string, :default => ""
      add_column :shipper_rates, :origin_country, :string, :default => ""
      add_column :shipper_rates, :destination_city, :string, :default => ""
      add_column :shipper_rates, :destination_state, :string, :default => ""
      add_column :shipper_rates, :destination_country, :string, :default => ""
  end
end
