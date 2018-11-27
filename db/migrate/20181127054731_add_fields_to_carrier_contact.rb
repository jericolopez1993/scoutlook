class AddFieldsToCarrierContact < ActiveRecord::Migration[5.2]
  def change
    add_column :carrier_contacts, :contact_type, :string
  end
end
