class DropDuplicateTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :client_contacts
    drop_table :client_locations
    drop_table :clients
    drop_table :locations
    drop_table :rates
  end
end
