class ModifyFieldsToRates < ActiveRecord::Migration[5.2]
  def change
      remove_column :rates, :origin_city
      remove_column :rates, :origin_state
      remove_column :rates, :origin_country
      remove_column :rates, :destination_city
      remove_column :rates, :destination_state
      remove_column :rates, :destination_country
      add_column :rates, :origin_location_id, :integer
      add_column :rates, :destination_location_id, :integer
  end
end
