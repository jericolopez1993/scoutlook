class AddEntryToMasterInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :master_invoices, :shipment_entry, :string
  end
end
