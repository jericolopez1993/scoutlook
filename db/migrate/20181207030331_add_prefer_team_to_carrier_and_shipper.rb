class AddPreferTeamToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :carrier_lanes, :prefer_team, :boolean, :default => false
    add_column :shipper_lanes, :prefer_team, :boolean, :default => false
  end

  def down
    remove_column :carrier_lanes, :prefer_team
    remove_column :shipper_lanes, :prefer_team
  end
end
