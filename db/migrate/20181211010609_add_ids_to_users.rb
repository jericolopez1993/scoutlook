class AddIdsToUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :client_contact_id
    add_column :users, :carrier_contact_id, :integer
    add_column :users, :shipper_contact_id, :integer
  end

  def down
    add_column :users, :client_contact_id, :integer
    remove_column :users, :carrier_contact_id
    remove_column :users, :shipper_contact_id
  end
end
