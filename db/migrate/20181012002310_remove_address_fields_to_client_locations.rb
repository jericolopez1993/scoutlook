class RemoveAddressFieldsToClientLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :client_locations, :address
    remove_column :client_locations, :state
    remove_column :client_locations, :postal
    remove_column :client_locations, :country
    remove_column :client_locations, :city
    remove_column :client_locations, :location_id
    add_column :client_locations, :location_id, :integer
  end
end
