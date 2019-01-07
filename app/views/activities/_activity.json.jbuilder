json.extract! activity, :id, :type, :engagement_type, :carrier_id, :user_id, :annual_value, :loads_per_week, :status, :date_opened, :date_closed, :notes, :outcome_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
