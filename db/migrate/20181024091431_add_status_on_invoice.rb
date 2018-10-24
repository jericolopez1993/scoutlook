class AddStatusOnInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :master_invoices, :own_status, :string
  end
end
