class AddCommoditiesToLanes < ActiveRecord::Migration[5.2]
  def change
    add_column :shipper_lanes, :commodities, :string
    add_column :carrier_lanes, :commodities, :string
  end
end
