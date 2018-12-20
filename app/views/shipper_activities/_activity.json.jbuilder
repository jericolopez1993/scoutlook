json.extract! shipper_activity, :id, :type, :engagement_type, :shipper_id, :user_id, :annual_value, :status, :date_opened, :date_closed, :notes, :outcome_id, :created_at, :updated_at
json.url shipper_activity_url(shipper_activity, format: :json)
