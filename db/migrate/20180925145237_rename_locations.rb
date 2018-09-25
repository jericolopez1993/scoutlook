class RenameLocations < ActiveRecord::Migration[5.2]
  def self.up
   rename_table :locations, :client_locations
 end

 def self.down
   rename_table :client_locations, :locations
 end
end
