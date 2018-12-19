class AddLocationFieldsToContacts < ActiveRecord::Migration[5.2]
  def up
    add_column :carrier_contacts, :city, :string, :default => ""
    add_column :carrier_contacts, :address, :string, :default => ""
    add_column :carrier_contacts, :state, :string, :default => ""
    add_column :carrier_contacts, :postal, :string, :default => ""
    add_column :carrier_contacts, :country, :string, :default => ""
    add_column :shipper_contacts, :city, :string, :default => ""
    add_column :shipper_contacts, :address, :string, :default => ""
    add_column :shipper_contacts, :state, :string, :default => ""
    add_column :shipper_contacts, :postal, :string, :default => ""
    add_column :shipper_contacts, :country, :string, :default => ""
  end
  
  def down
    remove_column :carrier_contacts, :city
    remove_column :carrier_contacts, :address
    remove_column :carrier_contacts, :state
    remove_column :carrier_contacts, :postal
    remove_column :carrier_contacts, :country
    remove_column :shipper_contacts, :city
    remove_column :shipper_contacts, :address
    remove_column :shipper_contacts, :state
    remove_column :shipper_contacts, :postal
    remove_column :shipper_contacts, :country
  end
end
