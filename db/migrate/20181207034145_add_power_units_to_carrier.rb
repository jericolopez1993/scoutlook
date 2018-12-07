class AddPowerUnitsToCarrier < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :power_units, :integer, :default => 0
    add_column :carriers, :company_drivers, :integer, :default => 0
  end

  def down
    remove_column :carriers, :power_units
    remove_column :carriers, :company_drivers
  end
end
