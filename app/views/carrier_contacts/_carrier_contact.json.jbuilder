json.extract! carrier_contact, :id, :title, :email, :work_phone, :home_phone, :address, :city, :state, :postal, :country, :carrier_id, :created_at, :updated_at
json.url carrier_contact_url(carrier_contact, format: :json)
