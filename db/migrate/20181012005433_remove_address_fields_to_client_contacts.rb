class RemoveAddressFieldsToClientContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :client_contacts, :address
    remove_column :client_contacts, :state
    remove_column :client_contacts, :postal
    remove_column :client_contacts, :country
    remove_column :client_contacts, :city
    add_column :client_contacts, :location_id, :integer
  end
end
