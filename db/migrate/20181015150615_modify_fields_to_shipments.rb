class ModifyFieldsToShipments < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipments, :origin_id
    remove_column :shipments, :origin_location_id
    remove_column :shipments, :destination_id
    remove_column :shipments, :destination_location_id
    add_column :shipments, :origin_location_id, :integer
    add_column :shipments, :destination_location_id, :integer
  end
end
