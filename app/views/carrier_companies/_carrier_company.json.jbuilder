json.extract! carrier_company, :id, :name, :city, :state, :company_type, :phone_number, :website, :created_at, :updated_at
json.url carrier_company_url(carrier_company, format: :json)
