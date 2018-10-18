class RemoveAddInvoiceNumberToShipmentAndMasterInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipments, :invoice_number
    add_column :master_invoices, :invoice_number, :string
  end
end
