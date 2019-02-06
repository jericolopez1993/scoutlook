json.extract! shipper_company, :id, :name, :city, :state, :company_type, :phone_number, :website, :created_at, :updated_at
json.url shipper_company_url(shipper_company, format: :json)
