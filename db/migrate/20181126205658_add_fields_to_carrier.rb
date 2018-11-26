class AddFieldsToCarrier < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :score_card, :string
    add_column :carriers, :freight_guard, :string
    add_column :carriers, :years_in_business, :integer, :default => 0
    add_column :carriers, :owner_operators, :integer, :default => 0
    add_column :carriers, :reefers, :integer, :default => 0
    add_column :carriers, :dry_vans, :integer, :default => 0
    add_column :carriers, :flat_beds, :integer, :default => 0
    add_column :carriers, :teams, :integer, :default => 0
    add_column :carriers, :contract_rates, :string
    add_column :carriers, :find_loads, :text
    remove_column :carrier_lanes, :lane_priority
    add_column :carrier_lanes, :lane_priority, :integer
  end
end
