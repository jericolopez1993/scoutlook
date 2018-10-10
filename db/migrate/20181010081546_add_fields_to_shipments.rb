class AddFieldsToShipments < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :account_number, :string
    add_column :shipments, :invoice_number, :string
  end
end
