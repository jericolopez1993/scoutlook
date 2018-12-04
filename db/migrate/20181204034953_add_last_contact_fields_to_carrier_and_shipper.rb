class AddLastContactFieldsToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def change
    remove_column :shippers, :relationship_owner
    add_column :shippers, :last_contact_by, :integer
    add_column :shippers, :last_contact, :date
    remove_column :carriers, :relationship_owner
    add_column :carriers, :last_contact_by, :integer
    add_column :carriers, :last_contact, :date
  end
end
