class AddAdditionalFieldsForShipments < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :money_currency, :string
    add_column :shipments, :received_date, :date
    add_column :shipments, :transit_time, :integer
    add_column :shipments, :own_type, :string
    add_column :shipments, :shipment_status, :string
  end
end
