class RemovedVarianceToMasterInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :master_invoices, :variance
  end
end
