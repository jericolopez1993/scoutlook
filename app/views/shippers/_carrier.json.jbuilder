json.extract! shipper, :id, :relationship_owner, :company_name, :shipper_id, :parent_id, :sales_priority, :address, :city, :state, :postal, :country, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :created_at, :updated_at
json.url shipper_url(shipper, format: :json)
