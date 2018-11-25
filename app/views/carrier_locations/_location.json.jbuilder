json.extract! location, :id, :carrier_id, :location_id, :name, :loc_type, :special_instructions, :address, :city, :state, :postal, :country, :phone, :created_at, :updated_at
json.url location_url(location, format: :json)
