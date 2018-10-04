class ModifyBilledRateUnitToShipment < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipments, :billed_rate_unit
    add_column :shipments, :billed_rate_unit, :string
  end
end
