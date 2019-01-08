json.extract! rate, :id, :carrier_id, :rate_type, :parent_id, :rate_level, :user_id, :effective_to, :effective_from, :origin_city, :origin_state, :origin_country, :destination_city, :destination_state, :destination_country, :freight_desc, :freight_classification, :transit_time, :minimum_density, :created_at, :updated_at
json.url rate_url(rate, format: :json)
