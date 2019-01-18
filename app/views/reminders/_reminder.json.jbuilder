json.extract! reminder, :id, :carrier_id, :shipper_id, :activity_id, :user_id, :reminder_date, :reminder_interval, :recurring, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
