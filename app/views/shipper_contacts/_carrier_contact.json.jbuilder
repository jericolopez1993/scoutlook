json.extract! shipper_contact, :id, :title, :email, :primary_phone, :secondary_phone, :address, :city, :state, :postal, :country, :shipper_id, :created_at, :updated_at
json.url shipper_contact_url(shipper_contact, format: :json)
