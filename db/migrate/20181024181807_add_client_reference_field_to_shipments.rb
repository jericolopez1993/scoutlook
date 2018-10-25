class AddClientReferenceFieldToShipments < ActiveRecord::Migration[5.2]
  def change
      add_column :shipments, :client_reference, :string
  end
end
