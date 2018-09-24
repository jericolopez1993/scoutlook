json.extract! client, :id, :client_type, :relationship_owner, :company_name, :client_id, :parent_id, :sales_priority, :address, :city, :state, :postal, :country, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :created_at, :updated_at
json.url client_url(client, format: :json)
