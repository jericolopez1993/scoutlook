class AddOldFieldsToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :loc_type, :string
    add_column :locations, :phone, :string
    add_column :locations, :is_origin, :boolean, :default => false
    add_column :locations, :is_destination, :boolean, :default => false
    add_column :locations, :client_id, :integer
  end
end
