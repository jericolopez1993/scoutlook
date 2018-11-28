class AddShipperAndCarrierToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :carrier_id, :integer
    add_column :activities, :shipper_id, :integer
  end
end
