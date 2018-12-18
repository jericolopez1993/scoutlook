class AddCarrierSetupAndOthersToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :carrier_setup, :integer
    add_column :carriers, :date_approved, :date
    remove_column :carrier_contacts, :work_phone
    remove_column :carrier_contacts, :home_phone
    add_column :carrier_contacts, :primary_phone, :string, :default => ""
    add_column :carrier_contacts, :primary_phone_type, :string, :default => ""
    add_column :carrier_contacts, :secondary_phone, :string, :default => ""
    add_column :carrier_contacts, :secondary_phone_type, :string, :default => ""
    add_column :shippers, :date_approved, :date
    remove_column :shipper_contacts, :work_phone
    remove_column :shipper_contacts, :home_phone
    add_column :shipper_contacts, :primary_phone, :string, :default => ""
    add_column :shipper_contacts, :primary_phone_type, :string, :default => ""
    add_column :shipper_contacts, :secondary_phone, :string, :default => ""
    add_column :shipper_contacts, :secondary_phone_type, :string, :default => ""
  end

  def down
    remove_column :carriers, :carrier_setup
    remove_column :carriers, :date_approved
    add_column :carrier_contacts, :work_phone, :string
    add_column :carrier_contacts, :home_phone, :string
    remove_column :carrier_contacts, :primary_phone
    remove_column :carrier_contacts, :primary_phone_type
    remove_column :carrier_contacts, :secondary_phone
    remove_column :carrier_contacts, :secondary_phone_type
    remove_column :shippers, :date_approved
    add_column :shipper_contacts, :work_phone, :string
    add_column :shipper_contacts, :home_phone, :string
    remove_column :shipper_contacts, :primary_phone
    remove_column :shipper_contacts, :primary_phone_type
    remove_column :shipper_contacts, :secondary_phone
    remove_column :shipper_contacts, :secondary_phone_type
  end
end
