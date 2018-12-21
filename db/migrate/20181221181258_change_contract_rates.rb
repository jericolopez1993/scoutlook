class ChangeContractRates < ActiveRecord::Migration[5.2]
  def change
    remove_column :carriers, :contract_rates
    add_column :carriers, :contract_rates, :boolean, :default => false
  end
end
