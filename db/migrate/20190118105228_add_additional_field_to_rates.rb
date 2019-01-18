class AddAdditionalFieldToRates < ActiveRecord::Migration[5.2]
  def up
    add_column :rates, :carrier_id, :integer
    add_column :rates, :shipper_id, :integer
    add_column :rates, :carrier_contact_id, :integer
    add_column :rates, :shipper_contact_id, :integer
  end

  def down
    remove_column :rates, :carrier_id
    remove_column :rates, :shipper_id
    remove_column :rates, :carrier_contact_id
    remove_column :rates, :shipper_contact_id
  end
end
