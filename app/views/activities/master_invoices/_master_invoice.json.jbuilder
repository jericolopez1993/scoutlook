json.extract! master_invoice, :id, :shipment_type, :shipper_id, :carrier_id, :master_account, :single_invoice_date, :invoicing_period_start, :invoicing_period_end, :total_charge, :variance, :variance_approved, :created_at, :updated_at
json.url master_invoice_url(master_invoice, format: :json)
