class AddCarrierIdToRates < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :carrier_id, :integer
  end
end
