class CreateMasterInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :master_invoices do |t|
      t.string :shipment_type
      t.integer :shipper_id
      t.integer :carrier_id
      t.string :master_account
      t.date :single_invoice_date
      t.date :invoicing_period_start
      t.date :invoicing_period_end
      t.decimal :total_charge
      t.decimal :variance
      t.boolean :variance_approved

      t.timestamps
    end
  end
end
