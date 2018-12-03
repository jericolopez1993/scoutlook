class ChangeShipperFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :shippers, :score_card
    remove_column :shippers, :freight_guard
    remove_column :shippers, :owner_operators
    remove_column :shippers, :reefers
    remove_column :shippers, :dry_vans
    remove_column :shippers, :flat_beds
    remove_column :shippers, :teams
    remove_column :shippers, :contract_rates
    remove_column :shippers, :total_fleet_size
    remove_column :shippers, :find_loads
    add_column :shippers, :shipper_type, :string
    add_column :shippers, :control_freight, :boolean, default: false
    add_column :shippers, :loads_per_month, :string
    add_column :shippers, :spend_per_year, :string
    add_column :shippers, :commodities, :string
    add_column :shippers, :commodities_notes, :text
    add_column :shippers, :blue_book_score, :integer
    add_column :shippers, :blue_book_url, :string
    add_column :shippers, :buying_criteria, :string
    add_column :shippers, :works_with_brokers, :boolean, default: false
    add_column :shippers, :price_sensitivity, :string
    add_column :shippers, :challenges, :text
    add_column :shippers, :current_carrier_mix, :text
    add_column :shippers, :prefer_teams, :boolean, default: false
  end
end
