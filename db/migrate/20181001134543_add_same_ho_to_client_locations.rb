class AddSameHoToClientLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :client_locations, :same_ho, :boolean, :default => false
  end
end
