class ModifyFieldsToSignal < ActiveRecord::Migration[5.2]
  def change
    remove_column :master_signals, :origin_city
    remove_column :master_signals, :origin_state
    remove_column :master_signals, :origin_country
    remove_column :master_signals, :destination_city
    remove_column :master_signals, :destination_state
    remove_column :master_signals, :destination_country
    add_column :master_signals, :origin_location_id, :integer
    add_column :master_signals, :destination_location_id, :integer
  end
end
