class ModifyAnnualRevenueToClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :annual_revenue
    add_column :clients, :annual_revenue, :string
  end
end
