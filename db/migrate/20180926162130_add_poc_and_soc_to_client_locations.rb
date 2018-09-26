class AddPocAndSocToClientLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :client_locations, :poc_id, :integer
    add_column :client_locations, :soc_id, :integer
  end
end
