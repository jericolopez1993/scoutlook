class AddExtensionNumberToContacts < ActiveRecord::Migration[5.2]
  def up
    add_column :carrier_contacts, :primary_extension_number, :string
    add_column :carrier_contacts, :secondary_extension_number, :string
    add_column :carrier_contacts, :notes, :text
    add_column :shipper_contacts, :primary_extension_number, :string
    add_column :shipper_contacts, :secondary_extension_number, :string
    add_column :shipper_contacts, :notes, :text
  end

  def down
    remove_column :carrier_contacts, :primary_extension_number
    remove_column :carrier_contacts, :secondary_extension_number
    remove_column :carrier_contacts, :notes
    remove_column :shipper_contacts, :primary_extension_number
    remove_column :shipper_contacts, :secondary_extension_number
    remove_column :shipper_contacts, :notes
  end
end
