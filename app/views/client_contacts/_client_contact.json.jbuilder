json.extract! client_contact, :id, :title, :email, :work_phone, :home_phone, :address, :city, :state, :postal, :country, :client_id, :created_at, :updated_at
json.url client_contact_url(client_contact, format: :json)
