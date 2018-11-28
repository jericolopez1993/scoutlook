json.extract! shipper_contact, :id, :title, :email, :work_phone, :home_phone, :address, :city, :state, :postal, :country, :shipper_id, :created_at, :updated_at
json.url shipper_contact_url(shipper_contact, format: :json)
