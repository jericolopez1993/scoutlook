class AddCarrierAndShipperToMessages < ActiveRecord::Migration[5.2]
  def up
    add_column :messages, :carrier_id, :integer
    add_column :messages, :shipper_id, :integer
  end

  def down
    remove_column :messages, :carrier_id
    remove_column :messages, :shipper_id
  end
end
